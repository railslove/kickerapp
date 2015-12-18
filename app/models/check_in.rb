class CheckIn < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
end
