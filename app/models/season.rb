class Season < ActiveRecord::Base
  include WithMatchStatistics
  belongs_to :league
  has_many :season_quota
  has_many :users, throught: :season_quota
  has_many :matches

  scope :active, -> { where('starts_at >= ? AND (ends_at <= ? OR ends_at IS NULL)', Time.zone.utc) }

  validates :starts_at, presence: true
  validates :league, presence: true
end
