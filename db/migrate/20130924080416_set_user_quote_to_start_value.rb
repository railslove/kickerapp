# frozen_string_literal: true

class SetUserQuoteToStartValue < ActiveRecord::Migration[4.2]
  def change
    change_column :users, :quote, :integer, default: 1200
  end
end
