class League < ActiveRecord::Base
  has_many :history_entries
  has_many :matches
  has_many :teams
  has_many :users

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :contact_email, presence: true

  before_save :sanitize_slug

  scope :by_matches, lambda { order('matches_count DESC') }

  def to_param
    self.slug
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

  def active_user_ranking
    users.reload.ranked.select(&:active?)
  end

  private

  def sanitize_slug
    self.slug = self.slug.downcase.parameterize
  end

  def ensure_user(user)
    user || NullUser.new
  end

  def reset_all_user_badges
    users.update_all(most_wins: false, top_crawler: false, worst_crawler: false, longest_winning_streak: false, most_teams: false, longest_winning_streak_ever: false )
  end
end
