class AddQuoteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :quote, :integer, default: 1200
  end
end
