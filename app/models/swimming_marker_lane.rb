class SwimmingMarkerLane < ApplicationRecord
  belongs_to :swimming_marker_block
  belongs_to :swimmer
  has_one :swimming_marker_group, through: :swimming_marker_block
  has_one :proof, through: :swimming_marker_group
  has_one :category, through: :swimming_marker_group
  has_one :competition, through: :proof

  validates :lane, presence: true, uniqueness: { scope: :swimming_marker_block_id }
  validates :swimmer_id, presence: true, uniqueness: { scope: :swimming_marker_block_id }

  delegate :position, to: :swimming_marker_block, prefix: true, allow_nil: true
  delegate :name, to: :proof, prefix: true, allow_nil: true
  delegate :name, to: :competition, prefix: true, allow_nil: true

  # Métodos para trabalhar com tempos
  def recorded_time_formatted
    return nil unless recorded_time.present?
    recorded_time.strftime("%M:%S.%L")
  end

  # Método para definir tempo a partir de string MM:SS.mmm
  def recorded_time_from_string(time_string)
    return nil if time_string.blank?

    begin
      # Usar strptime para parsing mais seguro
      Time.strptime(time_string, "%M:%S.%L")
    rescue => e
      Rails.logger.error "Erro ao converter tempo: #{time_string} - #{e.message}"
      nil
    end
  end
end
