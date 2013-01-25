class User < ActiveRecord::Base

  has_and_belongs_to_many :teams
  has_many :matches, :through => :teams

  def number_of_wins
    teams.sum(:number_of_wins)
  end

  def number_of_loses
    teams.sum(:number_of_loses)
  end

  def set_elo_quote(match)
    win = match.win_for_user?(self) ? 1 : 0
    partner = match.team_for_user(self).partner(self)
    opponent_quote = match.opponent_team_for_user(self).elo_quote
    self.quote = QuoteCalculator.elo_quote(quote, opponent_quote , win, partner.try(:quote) )
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

  def self.update_ranking
    find_each do |user|
      user.ranking = User.order("quote DESC").index(user)
      user.save
    end
  end
end
