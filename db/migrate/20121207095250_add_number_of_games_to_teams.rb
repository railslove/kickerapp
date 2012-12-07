class AddNumberOfGamesToTeams < ActiveRecord::Migration
  def up
    add_column :teams, :number_of_games, :integer, :default => 0
    Team.all.each do |team|
      team.update_attribute(:number_of_games, team.number_of_wins + team.number_of_loses)
    end
  end

  def down
    remove_column :teams, :number_of_games
  end
end
