class MatchScore < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :team, :match, :goals, :win

  belongs_to :team
  belongs_to :match

  scope :wins, where(:win => true)
  scope :loses, where(:win => false)

end
