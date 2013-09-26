FactoryGirl.define do
  factory :match do
    score "6:3"
    crawling false
    date Date.today
    difference 0
  end
end
