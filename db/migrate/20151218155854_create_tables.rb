class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :make
      t.string :model
    end
  end
end
