# == Schema Information
#
# Table name: new_matches
#
#  id                         :integer          not null, primary key
#  tournament_id              :integer
#  hometeam_id                :integer
#  awayteam_id                :integer
#  tournament_position        :integer
#  winner_next_match_position :integer
#  table_nr                   :integer
#

class NewMatch < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :hometeam, class_name: "Team"
  belongs_to :awayteam, class_name: "Team"
end
