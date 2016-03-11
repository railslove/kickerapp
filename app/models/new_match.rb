class NewMatch < ActiveRecord::Base
  belongs_to :tournament
  has_one :home_team, class_name: "Team"
  has_one :away_team, class_name: "Team"
end
