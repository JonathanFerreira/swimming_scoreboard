class SwimmingMarkerBlock < ApplicationRecord
  belongs_to :swimming_marker_group
  has_many :swimming_marker_lanes, dependent: :destroy
  has_many :swimmers, through: :swimming_marker_lanes

  accepts_nested_attributes_for :swimming_marker_lanes, allow_destroy: true

  validates :position, presence: true, uniqueness: { scope: :swimming_marker_group_id }
  validate :validate_unique_swimmers
  validate :validate_quantity_of_lanes

  private

  def validate_unique_swimmers
    current_lanes_swimmers = swimming_marker_lanes.map(&:swimmer_id)

    swimming_marker_group.swimming_marker_blocks.each do |block|
      if block.id != id
        block.swimming_marker_lanes.each do |lane|
          if current_lanes_swimmers.include?(lane.swimmer_id)
            errors.add(:base, "Não é permitido nadadores duplicados no mesmo bloco de balizamento")
          end
        end
      end
    end
  end

  def validate_quantity_of_lanes
    if swimming_marker_lanes.size > swimming_marker_group.proof.lane_quantity
      errors.add(:base, "Não é permitido mais raias do que o configurado para a prova")
    end
  end
end
