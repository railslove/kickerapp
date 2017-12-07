require 'active_support/concern'

module WithMatchStatistics
  extend ActiveSupport::Concern

  def most_wins
    users.where('number_of_wins > 0').order('number_of_wins desc, updated_at desc').take
  end

  def top_crawler
    users.where('number_of_crawls > 0').order('number_of_crawls desc, updated_at desc').take
  end

  def worst_crawler
    users.where('number_of_crawlings > 0').order('number_of_crawlings desc, updated_at desc').take
  end

  def longest_winning_streak
    users.where('winning_streak > 0').order('winning_streak desc, updated_at desc').take
  end

  def longest_winning_streak_ever
    users.order('longest_winning_streak_games desc').take
  end

  def most_teams
    users.sort_by(&:number_of_teams).last
  end

  def last_one
    active_user_ranking.last
  end
end
