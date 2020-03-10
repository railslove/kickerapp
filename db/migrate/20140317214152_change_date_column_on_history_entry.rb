# frozen_string_literal: true

class ChangeDateColumnOnHistoryEntry < ActiveRecord::Migration[4.2]
  def change
    change_column :history_entries, :date, :datetime
  end
end
