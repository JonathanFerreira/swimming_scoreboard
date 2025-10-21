class Proof < ApplicationRecord
  belongs_to :competition

  validates :name, :slug, :competition_id, presence: true

  has_many :proof_categories, dependent: :destroy
  has_many :categories, through: :proof_categories

  accepts_nested_attributes_for :proof_categories, reject_if: :all_blank, allow_destroy: true

  delegate :name, to: :competition, prefix: true, allow_nil: true

  def display_name
    "#{competition.name} - #{name}"
  end
end
