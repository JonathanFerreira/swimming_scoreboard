class Proof < ApplicationRecord
  belongs_to :competition

  validates :name, :slug, :competition_id, :lane_quantity, :gender, presence: true
  validates :lane_quantity, numericality: { greater_than: 0, less_than_or_equal_to: 10 }

  has_many :proof_categories, dependent: :destroy
  has_many :categories, through: :proof_categories

  accepts_nested_attributes_for :proof_categories, reject_if: :all_blank, allow_destroy: true

  delegate :name, to: :competition, prefix: true, allow_nil: true

  enum gender: {
    male: 'Masculino',
    female: 'Feminino'
  }

  def display_name
    "#{competition.name} - #{name}"
  end
end
