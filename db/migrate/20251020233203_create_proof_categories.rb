class CreateProofCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :proof_categories do |t|
      t.references :proof, null: false, foreign_key: true, index: true
      t.references :category, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
