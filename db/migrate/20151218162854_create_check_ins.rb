class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.integer :place_id
      t.integer :user_id
      t.datetime :time
      t.boolean :direct
    end

    add_index :check_ins, :place_id
    add_index :check_ins, :user_id
  end
end
