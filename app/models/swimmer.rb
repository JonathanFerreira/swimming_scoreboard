class Swimmer < ApplicationRecord
  enum gender: {
    male: 'Masculino',
    female: 'Feminino'
  }

  belongs_to :team, optional: true

  validates :name, :phone_number, :birthdate, :gender, presence: true
  validates :name, uniqueness: true

  delegate :name, to: :team, prefix: true, allow_nil: true
end
