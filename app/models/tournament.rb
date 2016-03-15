# == Schema Information
#
# Table name: tournaments
#
#  id               :integer          not null, primary key
#  name             :string
#  location         :string
#  number_of_tables :integer
#  created_at       :datetime
#  updated_at       :datetime

class Tournament < ActiveRecord::Base
  has_many :users
  has_many :teams
  has_many :new_matches

  def create_gameplan
    new_matches.delete_all
    create_teams
    team_ids = assign_team_ids
    1.upto(number_of_matches) do |i|
      match = self.new_matches.new(tournament_position: i, winner_next_match_position: calculate_winner_next_match_position(i), table_nr: calculate_table_nr(i))
      if i <= number_of_matches / 2
        match.hometeam_id = team_ids.delete_at(rand(team_ids.length))
        match.awayteam_id = team_ids.delete_at(rand(team_ids.length))
      else
        match.hometeam_id = nil
        match.awayteam_id = nil
      end
      match.save
    end

    self.new_matches.all.each do |match|
      winner_match = self.new_matches.find_by(tournament_position: match.winner_next_match_position)
      if winner_match
        if match.hometeam && !match.awayteam
          match.tournament_position % 2 == 0 ? winner_match.awayteam = match.hometeam : winner_match.hometeam = match.hometeam
        elsif match.awayteam && !match.hometeam
          match.tournament_position % 2 == 0 ? winner_match.awayteam = match.awayteam : winner_match.hometeam = match.awayteam
        end
        winner_match.save
      end
    end

  end

  def number_of_matches
    if teams.count < 2
      out = 0
    elsif teams.count == 2
      out = 1
    else
      out = 2**Math.log2(teams.count).ceil
    end
  end

  def create_teams
    teams.delete_all
    number_of_teams = (users.count / 2)
    user_ids = self.user_ids
    number_of_teams.times do  
      new_team = teams.create(player1_id: user_ids.delete_at(rand(user_ids.length)), player2_id: user_ids.delete_at(rand(user_ids.length)))
    end
  end

  private

  def assign_team_ids
    team_ids = self.team_ids
    (number_of_matches - team_ids.length).times do
      team_ids.push nil
    end
    team_ids
  end

  def calculate_table_nr(match_position)
    ((match_position - 1) % number_of_tables) + 1
  end

  def calculate_winner_next_match_position(match_position)
    if match_position < number_of_matches - 1
      (match_position / 2.0).round + (number_of_matches / 2)
    end
  end
end