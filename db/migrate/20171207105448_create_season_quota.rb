class CreateSeasonQuota < ActiveRecord::Migration
  def change
    create_table :season_quota do |t|
      t.integer :season_id, null: false
      t.integer :user_id, null: false
      t.integer :quota, default: 1_200
      t.integer :winning_streak, default: 0
      t.integer :number_of_crawls, default: 0
      t.integer :number_of_crawlings, default: 0
      t.boolean :top_crawler, default: false
      t.boolean :worst_crawler, default: false
      t.boolean :most_wins, default: false
      t.boolean :longest_winning_streak, default: false
      t.boolean :most_teams, default: false
      t.integer :longest_winning_streak_games, default: 0
      t.boolean :longest_winning_streak_ever, default: false

      t.timestamps null: false
    end

    add_index :season_quota, %i[season_id user_id], unique: true
  end
end
