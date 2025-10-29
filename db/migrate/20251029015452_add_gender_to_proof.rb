class AddGenderToProof < ActiveRecord::Migration[7.2]
  def change
    add_column :proofs, :gender, :string
    add_index :proofs, :gender
  end
end
