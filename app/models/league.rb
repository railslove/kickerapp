class League < ActiveRecord::Base
  has_many :matches
  has_many :teams
  has_many :users

  validate :name, presence: true
  validate :slug, presence: true, uniqness: true

  def to_param
    self.slug
  end

end
