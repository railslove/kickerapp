class AddLongestWinningStreakEverToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :longest_winning_streak_ever, :boolean, default: false
  end
end
