class Match < ActiveRecord::Base
  attr_accessible :crawling, :date

  has_many :match_scores
  has_many :teams, :through => :match_scores
  has_many :users, :through => :teams

  default_scope :order => "created_at DESC"

  scope :crawls, where(:crawling => true)

  after_create :calculate_user_quotes

  def winner_score
    match_scores.where(:win => true).first
  end

  def loser_score
    match_scores.where(:win => false).first
  end

  def win_for_user?(user)
    winner_score.team.users.include?(user)
  end

  def team_for_user(user)
    self.win_for_user?(user) ? self.winner_score.team : self.loser_score.team
  end

  def opponent_team_for_user(user)
    self.win_for_user?(user) ? self.loser_score.team : self.winner_score.team
  end

  def calculate_user_quotes
    self.users.each { |user| user.set_elo_quote(self)}
  end

  def self.create_from_params(params, team1, team2)
    [:set1, :set2, :set3].each do |set|
      next unless params[:team1][set].present? && params[:team2][set].present?
      match = self.create(:date => Date.today, :crawling => (params[:crawling] && params[:crawling][set].present?) || ((params[:team1][set].to_i-params[:team2][set].to_i).abs == 6) )
      match.match_scores.create(team: team1, goals: params[:team1][set], win: (params[:team1][set] > params[:team2][set]) )
      match.match_scores.create(team: team2, goals: params[:team2][set], win: (params[:team1][set] < params[:team2][set]) )
    end
  end

  def self.create_from_api(team1_with_score, team2_with_score, crawling)
    match = self.create(date: Date.today, crawling: crawling)
    match.match_scores.create(team: team1_with_score.last, goals: team1_with_score.first, win:  team1_with_score.first > team2_with_score.first)
    match.match_scores.create(team: team2_with_score.last, goals: team2_with_score.first, win:  team1_with_score.first < team2_with_score.first)
    match
  end
end
