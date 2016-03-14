# == Schema Information
#
# Table name: tournaments
#
#  id               :integer          not null, primary key
#  number_of_tables :integer
#  location         :string
#  name             :string

class Tournament < ActiveRecord::Base
  has_many :users
  has_many :teams
  has_many :new_matches

  def create_gameplan
    # Todo: Teams auslosen
    new_matches.delete_all
    create_teams
    team_ids = self.team_ids
    1.upto(number_of_matches) do |i|
      match = self.new_matches.new(tournament_position: i, winner_next_match_position: calculate_winner_next_match_position(i), table_nr: calculate_table_nr(i))
      if i <= number_of_matches/2
        match.hometeam_id = team_ids.delete_at(rand(team_ids.length))
        match.awayteam_id = team_ids.delete_at(rand(team_ids.length))
        p "#{match.hometeam.player1.name} & #{match.awayteam.player1.name}"
        p "#{match.hometeam.player2.name} & #{match.awayteam.player2.name}"
      end
      match.save
    end
  end

  def number_of_matches
    # Todo Handle Freilose
    teams.count
  end

  def create_teams
    teams.delete_all
    number_of_teams = (users.count / 2)
    user_ids = self.user_ids
    number_of_teams.times do
      new_team = teams.create(player1_id: user_ids.delete_at(rand(user_ids.length)), player2_id: user_ids.delete_at(rand(user_ids.length)))
      p '================'
      p new_team.id
      p new_team.player1.name
      p new_team.player2.name
      p '----------------'
    end
  end

  private

  def calculate_table_nr(match_position)
    ((match_position - 1) % number_of_tables) + 1
  end

  def calculate_winner_next_match_position(match_position)
    if match_position < number_of_matches - 1
      (match_position / 2.0).round + (number_of_matches / 2)
    end
  end



end
