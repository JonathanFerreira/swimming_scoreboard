class CreateSwimmingMarkerGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :swimming_marker_groups do |t|
      t.references :proof, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
