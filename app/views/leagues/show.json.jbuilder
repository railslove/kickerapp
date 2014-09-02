json.array! @league.matches do |match|
  json.(match, :score, :crawling, :difference)
  json.date I18n.l(match.date, format: :short)
  json.winner_team match.winner do |user|
    json.name user.name
    json.image user.image
    json.short_name user.short_name
  end
  json.looser_team match.looser do |user|
    json.name user.name
    json.image user.image
    json.short_name user.short_name
  end
end
