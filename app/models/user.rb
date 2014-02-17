class User < ActiveRecord::Base
  scope :ranked, lambda { order("quote DESC").where("updated_at > ?", Time.now - 2.weeks) }

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

  def win_percentage
    QuoteCalculator.win_loose_quote(self.number_of_wins, self.number_of_looses)
  end

  def set_elo_quote(match)
    win = match.win_for?(self) ? 1 : 0
    team_quote = win == 1 ? match.winner_team.elo_quote : match.looser_team.elo_quote
    opponent_quote = win == 1 ? match.looser_team.elo_quote : match.winner_team.elo_quote
    quote_change = QuoteCalculator.elo_quote(team_quote, opponent_quote , win )
    if match.crawling == true
      quote_change = win ? quote_change + 5 : quote_change - 5
    end
    self.quote = self.quote + quote_change
    win == 1 ? self.number_of_wins += 1 : self.number_of_looses += 1
    match.update_attributes(difference: quote_change.abs) unless match.difference > 0
    self.save
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.image = auth['info']['image']
    end
  end
end
