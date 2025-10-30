class CreateSwimmingMarkerBlocks < ActiveRecord::Migration[7.2]
  def change
    create_table :swimming_marker_blocks do |t|
      t.references :swimming_marker_group, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end

    add_index :swimming_marker_blocks, [:swimming_marker_group_id, :position], unique: true
  end
end
