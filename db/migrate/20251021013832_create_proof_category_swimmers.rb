class CreateProofCategorySwimmers < ActiveRecord::Migration[7.2]
  def change
    create_table :proof_category_swimmers do |t|
      t.references :proof, null: false, foreign_key: true, index: { name: "idx_proof_category_swimmers_on_proof_id" }
      t.references :category, null: false, foreign_key: true, index: { name: "idx_proof_category_swimmers_on_category_id" }
      t.references :swimmer, null: false, foreign_key: true, index: { name: "idx_proof_category_swimmers_on_swimmer_id" }

      t.timestamps
    end

    add_index :proof_category_swimmers, [:proof_id, :swimmer_id], unique: true, name: "idx_proof_category_swimmers_on_proof_id_swimmer_id"
  end
end
