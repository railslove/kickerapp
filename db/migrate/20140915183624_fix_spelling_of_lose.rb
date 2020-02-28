# frozen_string_literal: true

class FixSpellingOfLose < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :number_of_looses, :number_of_losses
    rename_column :teams, :number_of_looses, :number_of_losses
    rename_column :matches, :looser_team_id, :loser_team_id
  end
end
