# frozen_string_literal: true

class User < ActiveRecord::Base
  include WithPlayerStatistics

  belongs_to :league
  has_many :history_entries

  has_many :season_quota

  scope :ranked, -> { order('quota DESC') }

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, length: { maximum: 255 }
  validates :image, length: { maximum: 255 }

  BADGES = %w[crawling longest_winning most_teams winning_streak last_one crawler].freeze

  def teams
    Team.for_user(id)
  end

  def matches
    Match.by_user(id)
  end

  def short_name
    return '' unless name.present?
    s = name.split(' ')
    if s.length > 1
      s.map { |name| name[0] }.join
    else
      s.first[0..1]
    end
  end

  def set_elo_quota(match)
    win = match.win_for?(self) ? 1 : 0

    quota_change = win == 1 ? match.difference : -1 * match.difference

    if match.crawling == true
      if win == 1
        self.number_of_crawls += 1
      else
        self.number_of_crawlings += 1
      end
    end

    self.quota = quota + quota_change

    if win == 1
      self.number_of_wins += 1
    else
      self.number_of_losses += 1
    end

    save
    calculate_current_streak!
  end

  def self.create_with_omniauth(auth, league = nil)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.league_id = league.id
      user.email = auth['info']['email']
      user.image = auth['info']['image']
    end
  end

  def current_streak
    scope = Match.won_by(id)
    if date_of_last_lost_match = Match.lost_by(id).select(:date).reorder('date DESC').first
      scope = scope.where('date > ?', date_of_last_lost_match.date)
    end
    scope.count
  end

  def calculate_current_streak!
    self.winning_streak = current_streak
    save
  end

  def calculate_longest_streak!
    matches = self.matches.includes(:winner_team, :loser_team)
    current_winning_streak = 0
    matches.each do |match|
      if match.win_for?(self)
        current_winning_streak += 1
        if current_winning_streak > longest_winning_streak_games
          self.longest_winning_streak_games = current_winning_streak
        end
      else
        current_winning_streak = 0
      end
    end
    save
  end
end
