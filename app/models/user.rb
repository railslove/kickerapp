class User < ActiveRecord::Base

  has_and_belongs_to_many :teams
  has_many :matches, :through => :teams

  def number_of_wins
    teams.sum(:number_of_wins)
  end

  def number_of_loses
    teams.sum(:number_of_loses)
  end

  def quote
    QuoteCalculator.win_lose_quote(number_of_wins, number_of_loses)
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
