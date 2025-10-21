class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
