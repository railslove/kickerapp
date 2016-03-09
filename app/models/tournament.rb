# == Schema Information
#
# Table name: tournaments
#
#  id               :integer          not null, primary key
#  number_of_tables :integer
#  location         :string
#  name             :string
#

class Tournament < ActiveRecord::Base
  has_many :users
  has_many :teams
  has_many :matches
end
