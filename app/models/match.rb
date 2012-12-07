class Match < ActiveRecord::Base
  attr_accessible :crawling, :date

  has_many :match_scores
  has_many :teams, :through => :match_scores

  default_scope :order => "created_at DESC"

  scope :crawls, where(:crawling => true)

  def winner_score
    match_scores.where(:win => true).first
  end

  def loser_score
    match_scores.where(:win => false).first
  end

  def win_for_user?(user)
    winner_score.team.users.include?(user)
  end

  def self.create_from_params(params, team1, team2)
    [:set1, :set2, :set3].each do |set|
      next unless params[:team1][set].present? && params[:team2][set].present?
      match = self.create(:date => Date.today)
      match.match_scores.create(team: team1, goals: params[:team1][set], win: (params[:team1][set] > params[:team2][set]) )
      match.match_scores.create(team: team2, goals: params[:team2][set], win: (params[:team1][set] < params[:team2][set]) )
    end
  end
end
