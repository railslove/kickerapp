# == Schema Information
#
# Table name: history_entries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  league_id  :integer
#  match_id   :integer
#  quota      :integer
#  rank       :integer
#  created_at :datetime
#  updated_at :datetime
#  date       :datetime
#

class HistoryEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  belongs_to :match

  def self.track(match)
    ranking = match.active_user_ranking.map(&:id)
    match.users.each do |user|
      user.history_entries.create(
        league_id: match.league_id,
        match_id: match.id,
        quota: user.quota,
        date: match.date,
        rank: ranking.index(user.id) ? ranking.index(user.id)+1 : nil
      )
    end
  end

  def ranks
    [date, rank]
  end

  def quotas
    [date, quota]
  end
end
