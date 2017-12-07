require 'active_support/concern'

module WithPlayerStatistics
  extend ActiveSupport::Concern

  def number_of_games
    number_of_wins + number_of_losses
  end

  def number_of_teams
    teams.count
  end

  def active?
    matches.where('date > ?', 2.weeks.ago).any?
  end

  def win_percentage
    QuotaCalculator.win_lose_quota(number_of_wins, number_of_losses)
  end
end
