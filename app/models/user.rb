class User < ActiveRecord::Base
  has_many :teams
end
