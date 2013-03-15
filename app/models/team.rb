class Team < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :match_scores
  has_many :matches, :through => :match_scores
  has_and_belongs_to_many :users

  delegate :wins, :to => :match_scores
  delegate :loses, :to => :match_scores

  scope :ranked, order("quote DESC, number_of_wins DESC")
  #scope :doubles, joins(:teams_users).where

  def name
    users.map(&:name).join(" & ")
  end

  def record
    "#{number_of_wins} - #{number_of_loses}"
  end

  def update_scores(win)
    win ? update_attribute(:number_of_wins, number_of_wins + 1) : update_attribute(:number_of_loses, number_of_loses + 1)
    update_attribute(:number_of_games, number_of_games + 1)
    calculate_quote
  end

  def calculate_quote
    update_attribute(:quote, QuoteCalculator.win_lose_quote(number_of_wins, number_of_loses))
  end

  def elo_quote
    self.users.sum(:quote) / self.users.count
  end

  def partner(user)
    if self.users.count > 1
      self.users.where("id != #{user.id}").first
    else
      return nil
    end
  end

  def self.find_or_create_with_score(user_params)
    team = find_by_users(user_params)
    if team.nil?
      team = Team.create
      team.user_ids = user_params
    end
    team
  end

  def self.find_by_users(ids)
    user1 = User.find(ids.first)
    teams = user1.teams.includes(:users).where("users.id" => ids.last).first
  end

end
