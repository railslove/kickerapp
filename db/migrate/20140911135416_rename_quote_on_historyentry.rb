# frozen_string_literal: true

class RenameQuoteOnHistoryentry < ActiveRecord::Migration[4.2]
  def change
    rename_column :history_entries, :quote, :quota
  end
end
