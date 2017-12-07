# frozen_string_literal: true

require 'spec_helper'

feature 'view a league\'s badges page' do
  let!(:league) { create :league, name: 'The League', slug: 'the-league' }

  context 'top_crawler badge' do
    let!(:player) { create :user, league: league, name: 'Top Crawler', top_crawler: true, number_of_crawls: 20 }
    scenario 'shows player with top_crawler badge' do
      visit badges_league_path('the-league')

      within '.m-badge.as-crawler' do
        expect(page).to have_content 'TC'
        expect(page).to have_content '20'
        expect(page).to have_content 'Lässt die Gegner kriechen.'
      end
    end
  end

  context 'worst_crawler badge' do
    let!(:player) { create :user, league: league, name: 'Worst Crawler', worst_crawler: true, number_of_crawlings: 15 }
    scenario 'shows player with worst_crawler badge' do
      visit badges_league_path('the-league')

      within '.m-badge.as-crawling' do
        expect(page).to have_content 'WC'
        expect(page).to have_content '15'
        expect(page).to have_content 'Kennt den Tisch von unten wie kein anderer.'
      end
    end
  end

  context 'longest_winning_streak badge' do
    let!(:player) { create :user, league: league, name: 'Streak Winner', longest_winning_streak: true, winning_streak: 10 }
    scenario 'shows player with longest_winning_streak badge' do
      visit badges_league_path('the-league')

      within '.m-badge.as-longest_winning' do
        expect(page).to have_content 'SW'
        expect(page).to have_content '10'
        expect(page).to have_content '10 Siege in Folge.'
      end
    end
  end

  context 'longest_winning_streak_ever badge' do
    let!(:player) { create :user, league: league, name: 'Winner Ever', longest_winning_streak_ever: true, longest_winning_streak_games: 5 }
    scenario 'shows player with longest_winning_streak_ever badge' do
      visit badges_league_path('the-league')

      within '.m-badge.as-winning_streak' do
        expect(page).to have_content 'WE'
        expect(page).to have_content '5'
        expect(page).to have_content 'Die längste Siegesserie ever (5).'
      end
    end
  end

  context 'most_teams badge' do
    let!(:player1) { create :user, league: league, name: 'Player 1' }
    let!(:player2) { create :user, league: league, name: 'Player 2' }
    let!(:player3) { create :user, league: league, name: 'Player 3' }
    let!(:player4) { create :user, league: league, name: 'Player 4' }
    let!(:player5) { create :user, league: league, name: 'Player 5' }

    background do
      league.users.combination(2).each do |players|
        create :team, league: league, player1: players.first, player2: players.second
      end
      # give player2 a higher team count
      create :team, league: league, player1: player2, player2: player1
      create :team, league: league, player1: player2, player2: player3
    end

    scenario 'shows player with most_teams badge' do
      visit badges_league_path('the-league')

      within '.m-badge.as-most_teams' do
        expect(page).to have_content 'P2'
        expect(page).to have_content '6'
        expect(page).to have_content 'Ist sich für nichts zu schade. Meisten Doppelpartner.'
      end
    end
  end

  context 'last_one badge' do
    let!(:player1) { create :user, league: league, name: 'Player 1' }
    let!(:player2) { create :user, league: league, name: 'Player 2' }
    let!(:player3) { create :user, league: league, name: 'Player 3' }
    let!(:player4) { create :user, league: league, name: 'Player 4' }
    let!(:team1) { create :team, league: league, player1: player1, player2: player2 }
    let!(:team2) { create :team, league: league, player1: player3, player2: player4 }
    let!(:match) { create :match, winner_team: team1, loser_team: team2 }

    background do
      # give player1 the lowest quota
      player1.update_attribute :quota, 0
    end
    scenario 'shows player with last_one badge' do
      visit badges_league_path('the-league')

      within '.m-badge.as-last_one' do
        expect(page).to have_content 'P1'
        expect(page).to have_content 'Die rote Laterne.'
      end
    end
  end
end
