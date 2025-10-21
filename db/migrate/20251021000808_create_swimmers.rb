class CreateSwimmers < ActiveRecord::Migration[7.2]
  def change
    create_table :swimmers do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :phone_number, null: false, index: true
      t.date :birthdate, null: false, index: true
      t.string :gender, null: false, index: true
      t.references :team, foreign_key: true, index: true

      t.timestamps
    end
  end
end
