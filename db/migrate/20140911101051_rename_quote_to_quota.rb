class RenameQuoteToQuota < ActiveRecord::Migration
  def change
    rename_column :users, :quote, :quota
  end
end
