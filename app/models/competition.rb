class Competition < ApplicationRecord
  validates :name, :event_initial_date, :event_final_date, presence: true

  has_many :proofs, dependent: :destroy
end
