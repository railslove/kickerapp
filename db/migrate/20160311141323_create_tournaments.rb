class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :location
      t.integer :number_of_tables
      t.timestamps
    end
  end
end
