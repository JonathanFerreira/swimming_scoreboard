class AddLaneToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :lane, :string
  end
end
