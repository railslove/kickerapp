class SeasonQuotum < ActiveRecord::Base
  belongs_to :user
  belongs_to :season
  belongs_to :league, through: :season

  scoped :ranked, -> { order(quota: :desc) }
end
