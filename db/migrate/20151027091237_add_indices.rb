# frozen_string_literal: true

class AddIndices < ActiveRecord::Migration[4.2]
  def change
    # Create a sorted index to minimize result set size when counting data from past 2 weeks
    add_index :matches, :date, order: { date: :desc }

    # Add indices for winner and loser teams ids to tremendously speed up match data lookup
    add_index :matches, :winner_team_id
    add_index :matches, :loser_team_id

    # Do the same for teams
    add_index :teams, :player1_id
    add_index :teams, :player2_id
  end
end
