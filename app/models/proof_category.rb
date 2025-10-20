class ProofCategory < ApplicationRecord
  belongs_to :proof
  belongs_to :category

  validates :category_id, presence: true
  validates :category_id, uniqueness: { scope: :proof_id }
end
