class Friendship < ActiveRecord::Base
  belongs_to :user_1, class: 'User'
  belongs_to :user_2, class: 'User'
end
