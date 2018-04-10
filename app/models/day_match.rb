class DayMatch < ApplicationRecord
  belongs_to :league
  belongs_to :winner_team, class_name: "Team"
  belongs_to :loser_team, class_name: "Team"
  has_many :matches

  def self.create_and_calculate(matches, league)
    day_match = league.day_matches.new(date: Date.today)
    first_match = matches.shift
    team1 = first_match.winner_team
    team2 = first_match.loser_team
    difference = first_match.difference
    matches.each do |match|
      difference = difference + (match.difference * (team1 == match.winner_team ? 1 : -1))
    end
    if difference < 0
      day_match.update_attributes(winner_team: team2, loser_team: team1, difference: difference.abs)
    else
      day_match.update_attributes(winner_team: team1, loser_team: team2, difference: difference)
    end
    first_match.update_attributes(day_match: day_match)
    matches.each{|m| m.update_attributes(day_match: day_match)}
    day_match
  end
end
