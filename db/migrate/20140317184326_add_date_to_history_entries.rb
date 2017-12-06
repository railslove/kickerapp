# frozen_string_literal: true

class AddDateToHistoryEntries < ActiveRecord::Migration
  def change
    add_column :history_entries, :date, :date
  end
end
