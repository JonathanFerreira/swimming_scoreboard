class CreateCompetitions < ActiveRecord::Migration[7.2]
  def change
    create_table :competitions do |t|
      t.string :name
      t.date :event_initial_date
      t.date :event_final_date
      t.string :address
      t.text :description

      t.timestamps
    end
  end
end
