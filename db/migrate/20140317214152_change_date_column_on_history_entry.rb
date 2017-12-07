# frozen_string_literal: true

class ChangeDateColumnOnHistoryEntry < ActiveRecord::Migration
  def change
    change_column :history_entries, :date, :datetime
  end
end
