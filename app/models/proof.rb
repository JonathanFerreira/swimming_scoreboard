class Proof < ApplicationRecord
  belongs_to :competition

  validates :name, :slug, :competition_id, presence: true
end
