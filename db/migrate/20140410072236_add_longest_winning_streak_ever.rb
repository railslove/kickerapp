class AddLongestWinningStreakEver < ActiveRecord::Migration
  def change
    add_column :users, :longest_winning_streak_games, :integer, default: 0
  end
end
