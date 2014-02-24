class League < ActiveRecord::Base
  has_many :matches
  has_many :teams
  has_many :users

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  before_save :slugify

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.slug.downcase.parameterize
  end

end
