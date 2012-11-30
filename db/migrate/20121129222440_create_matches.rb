class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.boolean :crawling
      t.date :date
      t.timestamps
    end
  end
end
