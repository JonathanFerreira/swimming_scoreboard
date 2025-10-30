class Admin::SwimmerArrayParser
  def initialize(array_data)
    @array_data = array_data
  end

  def call
    parse_data
  end

  private

  attr_reader :array_data

  def parse_data
    proof_name = array_data[0]
    swimmer_name = array_data[1]
    phone_number = array_data[2]
    birthdate = array_data[3]
    gender_str = array_data[4]


    {
      original_data: {
        proof_name: proof_name,
        swimmer_name: swimmer_name,
        phone_number: phone_number,
        birthdate: birthdate,
        gender_str: gender_str
      },
      parsed_data: {
        swimmer_data: {
          name: swimmer_name,
          phone_number: format_phone_number(phone_number),
          birthdate: birthdate,
          gender: format_gender(gender_str)
        },
        proof_ids: find_proof_ids(proof_name, format_gender(gender_str))
      }
    }
  end

  def format_phone_number(phone_number)
    return nil if phone_number.blank?

    # remove .0
    phone = phone_number.to_s.gsub('.0', '')

    # Remove tudo que não é dígito
    digits_only = phone.gsub(/\D/, '')

    # Se tem 11 dígitos, formata como celular
    if digits_only.length == 11
      digits_only.gsub(/(\d{2})(\d{5})(\d{4})/, '(\1) \2-\3')
    # Se tem 10 dígitos, formata como telefone fixo
    elsif digits_only.length == 10
      digits_only.gsub(/(\d{2})(\d{4})(\d{4})/, '(\1) \2-\3')
    else
      phone # Retorna original se não conseguir formatar
    end
  end

  def format_gender(gender)
    return nil if gender.blank?

    case gender.downcase
    when 'masculino', 'm', 'male'
      'male'
    when 'feminino', 'f', 'female'
      'female'
    else
      nil
    end
  end

  def find_proof_ids(proof_name, gender)
    return [] if proof_name.blank?

    proof_ids = []
    proof_names = proof_name.split('+')

    proof_names.each do |proof_name|
      proof = Proof.find_by(slug: proof_name.strip.gsub(' ', '').downcase, gender: gender)
      proof_ids << proof.id if proof.present?
    end

    proof_ids.compact.uniq
  end
end
