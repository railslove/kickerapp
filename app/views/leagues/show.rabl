collection @matches
attributes :score, :crawling, :date, :difference
child(winner_team: :winner_team) {
  child(player1: :player1) { attributes :name, :image, :short_name }
  child(player2: :player2) { attributes :name, :image, :short_name }
}
child(looser_team: :looser_team) {
  child(player1: :player1) { attributes :name, :image, :short_name }
  child(player2: :player2) { attributes :name, :image, :short_name }
}
