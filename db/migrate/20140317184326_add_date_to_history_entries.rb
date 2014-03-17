class AddDateToHistoryEntries < ActiveRecord::Migration
  def change
    add_column :history_entries, :date, :date
  end
end
