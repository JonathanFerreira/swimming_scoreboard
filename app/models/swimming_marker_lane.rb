class SwimmingMarkerLane < ApplicationRecord
  belongs_to :swimming_marker_block
  belongs_to :swimmer

  validates :lane, presence: true, uniqueness: { scope: :swimming_marker_block_id }
  validates :swimmer_id, presence: true, uniqueness: { scope: :swimming_marker_block_id }
end
