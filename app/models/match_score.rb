class MatchScore < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :team, :match, :goals, :win

  belongs_to :team
  belongs_to :match

  scope :wins, where(:win => true)
  scope :loses, where(:win => false)

  after_create :calculate_wins_and_loses

  def calculate_wins_and_loses
    team.update_scores(win)
  end

end
