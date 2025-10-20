class Category < ApplicationRecord
  validates :name, :age_min, :age_max, presence: true
  validates :name, uniqueness: true
  validates :age_min, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :age_max, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :age_min, numericality: { less_than: :age_max }

  validate :validate_age_range_exists

  private

  def validate_age_range_exists
    if Category.where("age_min <= ? AND age_max >= ?", age_min, age_min).exists? ||
        Category.where("age_min <= ? AND age_max >= ?", age_max, age_max).exists?
        errors.add(:base, "Age range already exists")
    end
  end
end
