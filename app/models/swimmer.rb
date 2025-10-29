class Swimmer < ApplicationRecord
  GENDERS = {
    male: 'Masculino',
    female: 'Feminino'
  }

  belongs_to :team, optional: true
  has_many :swimming_marker_lanes, dependent: :destroy
  has_many :swimming_marker_blocks, through: :swimming_marker_lanes

  validates :name, :phone_number, :birthdate, :gender, presence: true
  validates :name, uniqueness: true

  delegate :name, to: :team, prefix: true, allow_nil: true

  def self.by_age_range(min_age, max_age)
    where("(strftime('%Y', 'now') - strftime('%Y', birthdate)) BETWEEN ? AND ?", min_age, max_age)
  end

  def age
    today = Date.current
    age = today.year - birthdate.year
    age -= 1 if today < Date.new(today.year, birthdate.month, birthdate.day)
    age
  end
end
