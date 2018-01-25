class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.integer :number_of_wins, default: 0
      t.integer :number_of_looses, default: 0
      t.integer :quote
      t.string :name

      t.timestamps
    end
  end
end
