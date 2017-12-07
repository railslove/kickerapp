# frozen_string_literal: true

widget :league_matches do
  key 'f73a3d3f7827b15719cabba16a4ec588e1d3f1ba'
  type 'leaderboard'
  data do
    {
      items: League.all.map { |l| { value: l.matches.where(date: (Date.today.beginning_of_week..Time.now)).count, label: l.name } }.sort { |x, y| y[:value] <=> x[:value] }.first(10)
    }
  end
end
