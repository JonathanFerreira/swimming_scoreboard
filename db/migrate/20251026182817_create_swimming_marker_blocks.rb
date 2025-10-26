class CreateSwimmingMarkerBlocks < ActiveRecord::Migration[7.2]
  def change
    create_table :swimming_marker_blocks do |t|
      t.references :swimming_marker_group, null: false, foreign_key: true
      t.integer :position, index: { unique: true }

      t.timestamps
    end
  end
end
