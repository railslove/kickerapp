# frozen_string_literal: true

class AddEloToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :quota, :integer, default: 1200
  end
end
