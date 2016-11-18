class User < ActiveRecord::Base

  belongs_to :league
  has_many :history_entries

  scope :ranked, lambda { order("quota DESC") }

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, length: { maximum: 255 }
  validates :image, length: { maximum: 255 }

  BADGES = %w{ crawling longest_winning most_teams winning_streak last_one crawler }
  DEFAULT_QUOTA = 1200

  def number_of_games
    number_of_wins + number_of_losses
  end

  def teams
    Team.for_user(self.id)
  end

  def number_of_teams
    teams.count
  end

  def matches
    Match.by_user(id)
  end

  def active?
    matches.where("date > ?", 2.weeks.ago).any?
  end

  def win_percentage
    QuotaCalculator.win_lose_quota(self.number_of_wins, self.number_of_losses)
  end

  def short_name
    return '' unless self.name.present?
    s = self.name.split(' ')
    if s.length > 1
      s.map{|name| name[0]}.join()
    else
      s.first[0..1]
    end
  end

  def update_stats
    self.attributes = { quota: DEFAULT_QUOTA, winning_streak: 0,
                        number_of_wins: 0, number_of_losses: 0,
                        number_of_crawls: 0, number_of_crawlings: 0,
                        longest_winning_streak_games: 0 }

    matches.by_user(id).order(date: :asc).each do |match|
      match.win_for?(self) ? match_won(match) : match_lost(match)
      self.longest_winning_streak_games = [winning_streak, longest_winning_streak_games].max
    end

    save
  end

  def self.create_with_omniauth(auth, league = nil)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.league_id = league.id
      user.email = auth["info"]["email"]
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
    self.save
  end

  def calculate_longest_streak!
    matches = self.matches.includes(:winner_team, :loser_team)
    current_winning_streak = 0
    matches.each do |match|
      if match.win_for?(self)
        current_winning_streak += 1
        if current_winning_streak > self.longest_winning_streak_games
          self.longest_winning_streak_games = current_winning_streak
        end
      else
        current_winning_streak = 0
      end
    end
    self.save
  end

  private

  def match_won(match)
    self.winning_streak += 1

    self.quota += match.difference
    self.number_of_crawls += 1 if match.crawling
    self.number_of_wins += 1
  end

  def match_lost(match)
    self.winning_streak = 0

    self.quota -= match.difference
    self.number_of_crawlings += 1 if match.crawling
    self.number_of_losses += 1
  end
end
