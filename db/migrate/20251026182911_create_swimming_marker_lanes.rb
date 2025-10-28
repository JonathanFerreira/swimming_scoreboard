class CreateSwimmingMarkerLanes < ActiveRecord::Migration[7.2]
  def change
    create_table :swimming_marker_lanes do |t|
      t.references :swimming_marker_block, null: false, foreign_key: true
      t.references :swimmer, null: false, foreign_key: true
      t.integer :lane

      t.timestamps
    end

    add_index :swimming_marker_lanes, [:swimming_marker_block_id, :lane], unique: true
    add_index :swimming_marker_lanes, [:swimming_marker_block_id, :swimmer_id], unique: true, name: "idx_swi_mar_lan_on_swi_mar_blo_id_swi_id"
  end
end
