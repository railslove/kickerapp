# frozen_string_literal: true

class AddLeagueIdToDayMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :day_matches, :league_id, :integer
    add_column :day_matches, :winner_team_id, :integer
    add_column :day_matches, :loser_team_id, :integer
    add_column :day_matches, :difference, :integer
  end
end
