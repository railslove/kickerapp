class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :default => nil # if you use this field as a username, you might want to make it :null => false.
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
