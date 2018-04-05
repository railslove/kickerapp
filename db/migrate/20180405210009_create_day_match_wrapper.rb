class CreateDayMatchWrapper < ActiveRecord::Migration[5.1]
  def change
    create_table :day_matches do |t|
      t.date :date
      t.timestamps
    end
    add_column :matches, :day_match_id, :integer
  end
end
