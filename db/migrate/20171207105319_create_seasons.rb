class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :league_id, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
