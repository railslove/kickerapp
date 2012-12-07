class CalculateQuotes < ActiveRecord::Migration
  def up
    Team.all.each do |team|
      team.number_of_wins = 0
      team.number_of_loses = 0
      team.quote = 0
      team.save
    end
    MatchScore.all.each { |m| m.calculate_wins_and_loses }
  end

  def down
  end
end
