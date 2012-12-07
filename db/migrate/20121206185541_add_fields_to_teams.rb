class AddFieldsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :number_of_wins, :integer, :default => 0
    add_column :teams, :number_of_loses, :integer, :default => 0
    add_column :teams, :quote, :float, :default => 0.0
  end
end
