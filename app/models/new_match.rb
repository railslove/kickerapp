class NewMatch < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :hometeam, class_name: "Team"
  belongs_to :awayteam, class_name: "Team"
end
