# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :league do
    name 'Railslove'
    slug 'railslove'
    contact_email 'contact@railslove.com'
  end
end
