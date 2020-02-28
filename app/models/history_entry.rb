# frozen_string_literal: true

class HistoryEntry < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :league, optional: true
  belongs_to :match, optional: true

  def self.track(match)
    ranking = match.active_user_ranking.map(&:id)
    match.users.each do |user|
      user.history_entries.create(
        league_id: match.league_id,
        match_id: match.id,
        quota: user.quota,
        date: match.date,
        rank: ranking.index(user.id) ? ranking.index(user.id) + 1 : nil
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
