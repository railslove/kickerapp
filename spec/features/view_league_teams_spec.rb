require 'spec_helper'

feature 'view a league\'s teams' do
  let!(:league) { create :league, name: 'The League', slug: 'the-league' }
  let!(:player1) { create :user, name: 'Player 1', league: league }
  let!(:player2) { create :user, name: 'Player 2', league: league }
  let!(:player3) { create :user, name: 'Player 3', league: league }
  let!(:player4) { create :user, name: 'Player 4', league: league }

  background do
    league.users.combination(2).each do |players|
      create :team, league: league, player1: players.first, player2: players.second
    end
    league.teams.permutation(2).each do |teams|
      create :match, winner_team: teams.first, loser_team: teams.second
    end
  end

  scenario 'valid entries' do
    visit league_teams_path('the-league')

    expect(page).to have_selector('table')
    expect(page.all('table tbody tr').count).to eql 6

    teams_points = page.all('table tbody tr td:last-child').map(&:text).map(&:to_i)
    expect(teams_points).to eql teams_points.sort.reverse
  end
end
