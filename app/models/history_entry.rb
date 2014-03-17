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
        date: match.date,
        rank: ranking.index(user.id) ? ranking.index(user.id)+1 : nil
      )
    end
  end

  def ranks
    [date, rank]
  end

  def quotes
    [date, quote]
  end
end
