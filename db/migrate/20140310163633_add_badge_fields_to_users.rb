# frozen_string_literal: true

class AddBadgeFieldsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :top_crawler, :boolean, default: false
    add_column :users, :worst_crawler, :boolean, default: false
    add_column :users, :most_wins, :boolean, default: false
    add_column :users, :longest_winning_streak, :boolean, default: false
  end
end
