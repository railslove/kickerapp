# == Schema Information
#
# Table name: leagues
#
#  id            :integer          not null, primary key
#  name          :string
#  slug          :string
#  created_at    :datetime
#  updated_at    :datetime
#  matches_count :integer          default(0)
#  contact_email :string
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :league do
    name 'Railslove'
    slug 'railslove'
    contact_email 'contact@railslove.com'
  end
end
