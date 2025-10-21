class ProofCategorySwimmer < ApplicationRecord
  belongs_to :proof, optional: true
  belongs_to :category, optional: true
  belongs_to :swimmer, optional: true
  has_one :competition, through: :proof

  validates :proof_id, :category_id, :swimmer_id, presence: true
  validates :proof_id, uniqueness: { scope: :swimmer_id }

  delegate :name, to: :proof, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :swimmer, prefix: true, allow_nil: true
  delegate :name, to: :competition, prefix: true, allow_nil: true
end
