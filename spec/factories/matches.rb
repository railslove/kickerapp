# == Schema Information
#
# Table name: matches
#
#  id             :integer          not null, primary key
#  winner_team_id :integer
#  loser_team_id  :integer
#  score          :string
#  crawling       :boolean
#  date           :datetime
#  difference     :integer          default(0)
#  league_id      :integer
#

FactoryGirl.define do
  factory :match do
    score "6:3"
    crawling false
    date Date.today
    difference 1
    association :winner_team, :factory => :team
    association :loser_team, :factory => :team
  end
end
