# frozen_string_literal: true

class AddMoreBadgeFlags < ActiveRecord::Migration
  def change
    add_column :users, :most_teams, :boolean, default: false
  end
end
