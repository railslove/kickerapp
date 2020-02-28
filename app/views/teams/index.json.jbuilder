# frozen_string_literal: true

json.array! @teams.each_with_index.to_a do |(team, index)|
  json.id team.id
  json.rank index + 1
  json.games team.number_of_games
  json.wins team.number_of_wins
  json.losses team.number_of_losses
  json.quota team.percentage
  json.score team.quota
  json.name team.name
  json.url league_team_url(current_league, team)
  json.player1 do
    json.id team.player1&.id
    json.name team.player1&.name
    json.image team.player1&.image
  end
  json.player2 do
    json.id team.player2&.id
    json.name team.player2&.name
    json.image team.player2&.image
  end
end
