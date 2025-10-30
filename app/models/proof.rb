class Proof < ApplicationRecord
  GENDERS = {
    male: 'Masculino',
    female: 'Feminino'
  }

  belongs_to :competition

  validates :name, :slug, :competition_id, :lane_quantity, :gender, presence: true
  validates :lane_quantity, numericality: { greater_than: 0, less_than_or_equal_to: 10 }

  has_many :proof_categories, dependent: :destroy
  has_many :categories, through: :proof_categories
  has_many :proof_category_swimmers, dependent: :destroy
  has_many :swimming_marker_groups, dependent: :destroy

  accepts_nested_attributes_for :proof_categories, reject_if: :all_blank, allow_destroy: true

  delegate :name, to: :competition, prefix: true, allow_nil: true


  def display_name
    "#{competition.name} - #{name} - #{GENDERS[gender.to_sym]}"
  end

  def name_and_gender
    "#{name} - #{GENDERS[gender.to_sym]}"
  end
end
