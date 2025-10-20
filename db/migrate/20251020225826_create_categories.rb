class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :age_min, null: false, index: true
      t.integer :age_max, null: false, index: true

      t.timestamps
    end
  end
end
