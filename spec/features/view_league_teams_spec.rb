require 'spec_helper'

feature 'view a league\'s teams' do
  let!(:league) { create :league, name: 'The League', slug: 'the-league' }
  let!(:player1) { create :user, name: 'Player 1', league: league }
  let!(:player2) { create :user, name: 'Player 2', league: league }
  let!(:player3) { create :user, name: 'Player 3', league: league }
  let!(:player4) { create :user, name: 'Player 4', league: league }
  let!(:team1) { create :team, league: league, player1: player1, player2: player2}
  let!(:team2) { create :team, league: league, player1: player3, player2: player4}
  let!(:match) { create :match, winner_team: team1, loser_team: team2 }


  scenario 'shows all teams ranked best first' do
    pending 'setup js engine'
    visit league_teams_path('the-league')

    expect(page).to have_selector('table')
    expect(page.all('table tbody tr').count).to eql 2

    teams_points = page.all('table tbody tr td:last-child').map(&:text).map(&:to_i)
    expect(teams_points).to eql teams_points.sort.reverse
  end
end
