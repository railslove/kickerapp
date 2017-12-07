# frozen_string_literal: true

class League < ActiveRecord::Base
  include WithMatchStatistics
  
  BASE_SCORE = 1_200

  mount_uploader :header_image, LeagueHeaderImageUploader

  has_many :history_entries
  has_many :matches
  has_many :teams
  has_many :users

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :contact_email, presence: true

  before_validation :sanitize_slug

  scope :by_matches, -> { order('matches_count DESC') }

  def to_param
    slug
  end

  def update_badges
    reset_all_user_badges
    ensure_user(most_wins).update_attribute(:most_wins, true)
    ensure_user(top_crawler).update_attribute(:top_crawler, true)
    ensure_user(worst_crawler).update_attribute(:worst_crawler, true)
    ensure_user(longest_winning_streak).update_attribute(:longest_winning_streak, true)
    ensure_user(most_teams).update_attribute(:most_teams, true)
    ensure_user(longest_winning_streak_ever).update_attribute(:longest_winning_streak_ever, true)
  end

  def active_user_ranking
    users
      .select('DISTINCT users.*')
      .joins('LEFT JOIN teams ON (teams.player1_id = users.id OR teams.player2_id = users.id)')
      .joins('LEFT JOIN matches ON (matches.winner_team_id = teams.id OR matches.loser_team_id = teams.id)')
      .where('DATE > ?', 2.weeks.ago)
      .reorder('quota DESC')
  end

  def team_ranking
    teams
      .select("teams.*, COUNT(matches.*) AS games_played, #{BASE_SCORE} + SUM(CASE WHEN matches.loser_team_id = teams.id THEN matches.difference * -1 ELSE matches.difference END) AS score")
      .joins('RIGHT JOIN matches ON (matches.winner_team_id = teams.id OR matches.loser_team_id = teams.id)')
      .for_doubles
      .includes(:player1, :player2)
      .group('teams.id')
      .order('score DESC')
  end
  
  private

  def sanitize_slug
    self.slug = slug.downcase.parameterize
  end

  def ensure_user(user)
    user || NullUser.new
  end

  def reset_all_user_badges
    users.update_all(most_wins: false, top_crawler: false, worst_crawler: false, longest_winning_streak: false, most_teams: false, longest_winning_streak_ever: false)
  end

  def reset_user_accounts
    users.update_all(quota: 1200, winning_streak: 0, number_of_crawls: 0, number_of_crawlings: 0, longest_winning_streak_games: 0)
  end
end
