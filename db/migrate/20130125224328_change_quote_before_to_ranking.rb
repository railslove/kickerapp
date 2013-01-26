class ChangeQuoteBeforeToRanking < ActiveRecord::Migration
  def up
    rename_column :users, :quote_before, :ranking
    change_column :users, :ranking, :integer, :default => 0
  end

  def down
    rename_column :users, :ranking, :quote_before
    change_column :users, :quote_before, :integer, :default => 1200
  end
end
