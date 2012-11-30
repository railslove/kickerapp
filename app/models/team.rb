class Team < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :match_scores
  has_many :matches, :through => :match_scores
  has_and_belongs_to_many :users

  def name
    users.map(&:name).join(" und ")
  end

  def wins
    match_scores.wins.map(&:match)
  end

  def loses
    match_scores.loses.map(&:match)
  end

  def record
    "#{self.match_scores.wins.count} - #{self.match_scores.loses.count}"
  end

  def self.find_or_create_with_score(match,params,win)
    team = find_by_users(params[:user])
    unless team.present?
      team = Team.create
      team.user_ids = params[:user]
    end
    team.match_scores.create(:match => match, :goals => params[:goals], :win => win)
    team
  end

  def self.find_by_users(ids)
    user1 = User.find(ids.first)
    teams = user1.teams.includes(:users).where("users.id" => ids.last).first
  end

end
