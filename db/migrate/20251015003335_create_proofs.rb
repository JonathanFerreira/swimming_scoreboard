class CreateProofs < ActiveRecord::Migration[7.2]
  def change
    create_table :proofs do |t|
      t.string :name
      t.string :slug
      t.references :competition, null: false, foreign_key: true, null: false

      t.timestamps
    end
  end
end
