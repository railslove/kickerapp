# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[4.2]
  def change
    create_table :teams do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.integer :number_of_wins, default: 0
      t.integer :number_of_looses, default: 0

      t.timestamps
    end
  end
end
