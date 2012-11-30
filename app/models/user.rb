class User < ActiveRecord::Base

  has_and_belongs_to_many :teams
  has_many :matches, :through => :teams

  def wins(crawls = false)
    matches = teams.map{|t| t.wins}.flatten
    matches = matches.select(&:crawling?) if crawls.present?
    matches
  end

  def loses(crawls = false)
    matches = teams.map{|t| t.loses}.flatten
    matches = matches.select(&:crawling?) if crawls
    matches
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.image = auth['info']['image']
    end
  end
end
