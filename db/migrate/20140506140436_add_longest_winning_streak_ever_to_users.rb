# frozen_string_literal: true

class AddLongestWinningStreakEverToUsers < ActiveRecord::Migration
  def change
    add_column :users, :longest_winning_streak_ever, :boolean, default: false
  end
end
