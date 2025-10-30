class Admin::SwimmerImportItemService
  def initialize(data)
    @original_data = data[:original_data]
    @parsed_data = data[:parsed_data]
  end

  def call
    ApplicationRecord.transaction do
      swimmer = import_new_one
      import_proof_category_swimmers(swimmer)
      { success: true }
    end
  rescue => e
    Rails.logger.error "####################### Erro ao importar nadador: #{e.message}"
    Rails.logger.error "####################### Original data: #{original_data}"
    Rails.logger.error "####################### Parsed data: #{parsed_data}"
    Rails.logger.error "####################### Error: #{e.backtrace.join("\n")}"
    Rails.logger.error "####################### Error: #{e.backtrace.join("\n")}"
    { success: false, error: [original_data, parsed_data, e.message] }
  end

  private

  attr_reader :original_data, :parsed_data

  def import_new_one
    swimmer_data = parsed_data[:swimmer_data]

    Swimmer.find_or_initialize_by(name: swimmer_data[:name]).tap do |swimmer|
      swimmer.assign_attributes(swimmer_data)
      swimmer.save!
    end
  end

  def import_proof_category_swimmers(swimmer)
    proof_ids = parsed_data[:proof_ids]
    category = Category.find_by_age(swimmer.age)

    proof_ids.each do |proof_id|
      proof = Proof.find(proof_id)
      swimmer.proof_category_swimmers.create!(proof: proof, category: category)
    end
  end
end
