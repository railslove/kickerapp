# frozen_string_literal: true

json.array! @matches do |match|
  json.call(match, :score, :crawling, :difference)
  json.date I18n.l(match.date, format: :short)
  json.winner_team match.winner do |user|
    json.name user.name
    json.image user.image
    json.short_name user.short_name
  end
  json.loser_team match.loser do |user|
    json.name user.name
    json.image user.image
    json.short_name user.short_name
  end
end
