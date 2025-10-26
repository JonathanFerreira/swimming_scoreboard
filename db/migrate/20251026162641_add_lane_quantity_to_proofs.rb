class AddLaneQuantityToProofs < ActiveRecord::Migration[7.2]
  def change
    add_column :proofs, :lane_quantity, :integer
    add_index :proofs, :lane_quantity
  end
end
