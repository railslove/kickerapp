class AddQuoteBeforeToUser < ActiveRecord::Migration
  def change
    add_column :users, :quote_before, :integer, :default => 1200
  end
end
