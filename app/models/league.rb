class League < ActiveRecord::Base
  has_many :history_entries
  has_many :matches
  has_many :teams
  has_many :users

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  before_save :slugify

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.slug.downcase.parameterize
  end

  def update_badges
    self.users.update_all(most_wins: false, top_crawler: false, worst_crawler: false, longest_winning_streak: false, most_teams: false, longest_winning_streak_ever: false )

    most_wins.update_attribute(:most_wins, true) if most_wins && most_wins.number_of_wins > 0
    top_crawler.update_attribute(:top_crawler, true) if top_crawler && top_crawler.number_of_crawls > 0
    worst_crawler.update_attribute(:worst_crawler, true) if worst_crawler && worst_crawler.number_of_crawlings > 0
    longest_winning_streak.update_attribute(:longest_winning_streak, true) if longest_winning_streak && longest_winning_streak.winning_streak > 0
    most_teams.update_attribute(:most_teams, true) if most_teams
    longest_winning_streak_ever.update_attribute(:longest_winning_streak_ever, true) if longest_winning_streak_ever

  end

  def top_crawler
    self.users.order('number_of_crawls desc').order('updated_at desc').take
  end

  def most_wins
    self.users.order('number_of_wins desc').order('updated_at desc').take
  end

  def worst_crawler
    self.users.order('number_of_crawlings desc').order('updated_at desc').take
  end

  def longest_winning_streak
    self.users.order('winning_streak desc').order('updated_at desc').take
  end

  def most_teams
    self.users.sort_by{ |u| u.teams.count }.last
  end

  def last_one
    active_user_ranking.last
  end

  def longest_winning_streak_ever
    self.users.order('longest_winning_streak_games desc').take
  end

  def active_user_ranking
    users.reload.ranked.select{ |u| u.active? }
  end

end
