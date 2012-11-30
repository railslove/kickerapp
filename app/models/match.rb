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
end
