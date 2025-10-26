class SwimmingMarkerGroup < ApplicationRecord
  belongs_to :proof
  belongs_to :category
  has_one :competition, through: :proof

  delegate :name, to: :proof, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :competition, prefix: true, allow_nil: true
end
