# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  number_of_wins               :integer          default(0)
#  number_of_losses             :integer          default(0)
#  quota                        :integer          default(1200)
#  name                         :string
#  created_at                   :datetime
#  updated_at                   :datetime
#  provider                     :string
#  uid                          :string
#  image                        :string
#  league_id                    :integer
#  email                        :string
#  winning_streak               :integer          default(0)
#  number_of_crawls             :integer          default(0)
#  number_of_crawlings          :integer          default(0)
#  top_crawler                  :boolean          default(FALSE)
#  worst_crawler                :boolean          default(FALSE)
#  most_wins                    :boolean          default(FALSE)
#  longest_winning_streak       :boolean          default(FALSE)
#  most_teams                   :boolean          default(FALSE)
#  longest_winning_streak_games :integer          default(0)
#  longest_winning_streak_ever  :boolean          default(FALSE)
#  tournament_id                :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    number_of_wins 1
    number_of_losses 1
    number_of_crawls 1
    number_of_crawlings 1
    winning_streak 1
    quota 1200
    name "MyString"
    email 'peter@pan.de'
  end
end
