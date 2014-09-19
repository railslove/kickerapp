class User < ActiveRecord::Base

  belongs_to :league
  has_many :history_entries

  scope :ranked, lambda { order("quota DESC") }

  validates :name, presence: true

  BADGES = %w{ crawling longest_winning most_teams winning_streak last_one crawler }

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
    team_ids = teams.pluck(:id)
    Match.where("winner_team_id IN (?) OR loser_team_id IN (?)", team_ids, team_ids)
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

  def set_elo_quota(match)
    win = match.win_for?(self) ? 1 : 0

    quota_change = (win == 1) ? match.difference : -1 * match.difference

    if match.crawling == true
      if win == 1
        self.number_of_crawls += 1
      else
        self.number_of_crawlings += 1
      end
    end

    self.quota = self.quota + quota_change

    if win == 1
      self.number_of_wins += 1
    else
      self.number_of_losses += 1
    end

    self.save
    calculate_current_streak!
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
    wins = []
    matches.each do |m|
      if m.win_for?(self)
        wins << m
      else
        break
      end
    end
    wins.length
  end

  def calculate_current_streak!
    self.winning_streak = current_streak
    self.save
  end

  def calculate_longest_streak!
    matches = self.matches
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
end
