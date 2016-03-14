# == Schema Information
#
# Table name: teams
#
#  id               :integer          not null, primary key
#  player1_id       :integer
#  player2_id       :integer
#  number_of_wins   :integer          default(0)
#  number_of_losses :integer          default(0)
#  created_at       :datetime
#  updated_at       :datetime
#  league_id        :integer
#  tournament_id    :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    association :player1, :factory => :user
    number_of_wins 1
    number_of_losses 1
  end
end
