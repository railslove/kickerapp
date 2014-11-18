# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    association :player1, :factory => :user
    number_of_wins 1
    number_of_losses 1
  end
end
