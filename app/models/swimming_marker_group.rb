class SwimmingMarkerGroup < ApplicationRecord
  belongs_to :proof
  belongs_to :category
  has_one :competition, through: :proof
  has_many :swimming_marker_blocks, dependent: :destroy

  delegate :name, to: :proof, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :competition, prefix: true, allow_nil: true

  def swimmers_list
    ProofCategorySwimmer.where(proof_id: proof_id, category_id: category_id).includes(:swimmer).map(&:swimmer)
  end
end
