class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_1_id
      t.integer :user_2_id
    end
    add_index :friendships, :user_1_id
    add_index :friendships, :user_2_id
  end
end
