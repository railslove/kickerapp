class SetUserQuoteToStartValue < ActiveRecord::Migration
  def change
    change_column :users, :quote, :integer, default: 1200
  end
end
