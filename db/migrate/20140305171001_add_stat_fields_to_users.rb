class AddStatFieldsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :winning_streak, :integer, default: 0
    add_column :users, :number_of_crawls, :integer, default: 0
    add_column :users, :number_of_crawlings, :integer, default: 0
  end
end
