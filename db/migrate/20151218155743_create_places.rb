class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :long
      t.text :description
    end
  end
end
