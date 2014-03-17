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
        quote: user.quote,
        rank: ranking.index(user.id) ? ranking.index(user.id)+1 : nil
      )
    end
  end

  def ranks
    [created_at.to_date, rank]
  end

  def quotes
    [created_at.to_date, quote]
  end
end
