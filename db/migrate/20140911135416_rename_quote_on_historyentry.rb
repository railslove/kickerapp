# frozen_string_literal: true

class RenameQuoteOnHistoryentry < ActiveRecord::Migration
  def change
    rename_column :history_entries, :quote, :quota
  end
end
