class AddRecordedTimeToSwimmingMarkerLane < ActiveRecord::Migration[7.2]
  def change
    add_column :swimming_marker_lanes, :recorded_time, :time, precision: 3
    add_index :swimming_marker_lanes, :recorded_time
  end
end
