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

  validate :validate_swimmer_gender
  validate :validate_swimmer_age

  private

  def validate_swimmer_gender
    if swimmer.gender != proof.gender
      errors.add(:base, "O gênero do nadador não corresponde ao gênero da prova")
    end
  end

  def validate_swimmer_age
    if swimmer.age < category.age_min || swimmer.age > category.age_max
      errors.add(:base, "A idade do nadador não corresponde ao intervalo de idade da prova")
    end
  end
end
