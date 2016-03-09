class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.integer :number_of_tables
      t.string :location
      t.string :name
    end
  end
end
