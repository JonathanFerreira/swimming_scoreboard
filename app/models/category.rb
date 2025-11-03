class Category < ApplicationRecord

  has_many :proof_categories, dependent: :destroy
  has_many :proofs, through: :proof_categories

  validates :name, :age_min, :age_max, presence: true
  validates :name, uniqueness: true
  validates :age_min, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :age_max, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :age_min, numericality: { less_than: :age_max }

  validate :validate_age_range_exists

  def self.find_by_age_and_proof_id(age, proof_id)
    joins(:proof_categories)
    .where(proof_categories: { proof_id: proof_id })
    .where("age_min <= ? AND age_max >= ?", age, age)
    .last
  end

  private

  def validate_age_range_exists
    if Category.where("age_min <= ? AND age_max >= ?", age_min, age_min).exists? ||
        Category.where("age_min <= ? AND age_max >= ?", age_max, age_max).exists?
        errors.add(:base, "Age range already exists")
    end
  end
end
