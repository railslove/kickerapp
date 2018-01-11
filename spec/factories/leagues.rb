# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :league do
    name 'Railslove'
    slug 'railslove'
    contact_email 'contact@railslove.com'
  end
end
