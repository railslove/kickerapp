class User < ActiveRecord::Base

  belongs_to :league

  scope :ranked, lambda { order("quote DESC") }

  validates :name, presence: true

  def number_of_games
    number_of_wins + number_of_looses
  end

  def teams
    Team.for_user(self.id)
  end

  def matches
    self.teams.map{|team| team.matches}.flatten.sort{|x,y| y.date <=> x.date}
  end

  def active?
    self.matches.any? && self.matches.first.date > 2.weeks.ago
  end

  def win_percentage
    QuoteCalculator.win_loose_quote(self.number_of_wins, self.number_of_looses)
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

  def set_elo_quote(match)
    win = match.win_for?(self) ? 1 : 0

    quote_change = (win == 1) ? match.difference : -1 * match.difference

    if match.crawling == true
      if win == 1
        self.number_of_crawls += 1
      else
        self.number_of_crawlings += 1
      end
    end

    self.quote = self.quote + quote_change

    if win == 1
      self.number_of_wins += 1
      self.winning_streak += 1
    else
      self.number_of_looses += 1
      self.winning_streak = 0
    end

    self.save
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
end
