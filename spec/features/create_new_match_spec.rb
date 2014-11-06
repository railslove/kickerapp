require 'spec_helper'

feature 'create new match' do
  let!(:league) { FactoryGirl.create(:league, name: 'The League', slug: 'the-league') }
  let!(:player1) { FactoryGirl.create(:user, name: 'Player 1', league: league) }
  let!(:player2) { FactoryGirl.create(:user, name: 'Player 2', league: league) }
  let!(:player3) { FactoryGirl.create(:user, name: 'Player 3', league: league) }
  let!(:player4) { FactoryGirl.create(:user, name: 'Player 4', league: league) }

  context 'with 4 players' do
    scenario 'valid entries' do
      visit new_league_match_path('the-league')

      select 'Player 1', from: 'team1_player1'
      select 'Player 2', from: 'team1_player2'
      select 'Player 3', from: 'team2_player1'
      select 'Player 4', from: 'team2_player2'

      fill_in 'set1_team1', with: '6'
      fill_in 'set1_team2', with: '3'
      fill_in 'set2_team1', with: '7'
      fill_in 'set2_team2', with: '5'

      click_button 'Eintragen'

      expect(current_path).to eql league_path('the-league')
      expect(page).to have_content 'Das Spiel wurde eingetragen!'
      expect(page).to have_content 'Player 1'
      expect(page).to have_content 'Player 2'
      expect(page).to have_content 'Player 3'
      expect(page).to have_content 'Player 4'
      expect(page).to have_content '6:3'
      expect(page).to have_content '7:5'
    end
    scenario 'invalid entries with same player in both teams' do
      pending 'code fix required'
      visit new_league_match_path('the-league')

      select 'Player 1', from: 'team1_player1'
      select 'Player 2', from: 'team1_player2'
      select 'Player 1', from: 'team2_player1'
      select 'Player 4', from: 'team2_player2'

      fill_in 'set1_team1', with: '6'
      fill_in 'set1_team2', with: '3'
      fill_in 'set2_team1', with: '7'
      fill_in 'set2_team2', with: '5'

      click_button 'Eintragen'

      expect(current_path).to eql new_league_match_path('the-league')
      expect(page).to have_content 'Das Spiel konnte nicht gespeichert werden.'
    end
    scenario 'invalid entries' do
      pending 'code fix required'
      visit new_league_match_path('the-league')

      select 'Player 1', from: 'team1_player1'
      select 'Player 2', from: 'team1_player2'
      select 'Player 1', from: 'team2_player1'
      select 'Player 4', from: 'team2_player2'

      fill_in 'set1_team1', with: '6'
      fill_in 'set1_team2', with: '3'
      fill_in 'set2_team1', with: '7'
      fill_in 'set2_team2', with: '5'

      click_button 'Eintragen'

      expect(current_path).to eql new_league_match_path('the-league')
      expect(page).to have_content 'Das Spiel konnte nicht gespeichert werden.'
    end
  end

  context 'with 2 players' do
    scenario 'selecting from team1_player1 and team2_player1' do
      visit new_league_match_path('the-league')

      select 'Player 1', from: 'team1_player1'
      select 'Player 3', from: 'team2_player1'

      fill_in 'set1_team1', with: '6'
      fill_in 'set1_team2', with: '3'
      fill_in 'set2_team1', with: '7'
      fill_in 'set2_team2', with: '5'

      click_button 'Eintragen'

      expect(current_path).to eql league_path('the-league')
      expect(page).to have_content 'Das Spiel wurde eingetragen!'
      expect(page).to have_content 'Player 1'
      expect(page).to have_content 'Player 3'
      expect(page).to have_content '6:3'
      expect(page).to have_content '7:5'
    end
    scenario 'selecting from team1_player1 and team2_player2' do
      visit new_league_match_path('the-league')

      select 'Player 1', from: 'team1_player1'
      select 'Player 3', from: 'team2_player2'

      fill_in 'set1_team1', with: '6'
      fill_in 'set1_team2', with: '3'
      fill_in 'set2_team1', with: '7'
      fill_in 'set2_team2', with: '5'

      click_button 'Eintragen'

      expect(current_path).to eql league_path('the-league')
      expect(page).to have_content 'Das Spiel wurde eingetragen!'
      expect(page).to have_content 'Player 1'
      expect(page).to have_content 'Player 3'
      expect(page).to have_content '6:3'
      expect(page).to have_content '7:5'
    end
    scenario 'selecting from team1_player2 and team2_player1' do
      visit new_league_match_path('the-league')

      select 'Player 1', from: 'team1_player2'
      select 'Player 3', from: 'team2_player1'

      fill_in 'set1_team1', with: '6'
      fill_in 'set1_team2', with: '3'
      fill_in 'set2_team1', with: '7'
      fill_in 'set2_team2', with: '5'

      click_button 'Eintragen'

      expect(current_path).to eql league_path('the-league')
      expect(page).to have_content 'Das Spiel wurde eingetragen!'
      expect(page).to have_content 'Player 1'
      expect(page).to have_content 'Player 3'
      expect(page).to have_content '6:3'
      expect(page).to have_content '7:5'
    end
    scenario 'selecting from team1_player2 and team2_player2' do
      visit new_league_match_path('the-league')

      select 'Player 1', from: 'team1_player2'
      select 'Player 3', from: 'team2_player2'

      fill_in 'set1_team1', with: '6'
      fill_in 'set1_team2', with: '3'
      fill_in 'set2_team1', with: '7'
      fill_in 'set2_team2', with: '5'

      click_button 'Eintragen'

      expect(current_path).to eql league_path('the-league')
      expect(page).to have_content 'Das Spiel wurde eingetragen!'
      expect(page).to have_content 'Player 1'
      expect(page).to have_content 'Player 3'
      expect(page).to have_content '6:3'
      expect(page).to have_content '7:5'
    end
  end

  scenario 'with crawling' do
    visit new_league_match_path('the-league')

    select 'Player 1', from: 'team1_player1'
    select 'Player 2', from: 'team1_player2'
    select 'Player 3', from: 'team2_player1'
    select 'Player 4', from: 'team2_player2'

    fill_in 'set1_team1', with: '6'
    fill_in 'set1_team2', with: '3'
    fill_in 'set2_team1', with: '7'
    fill_in 'set2_team2', with: '5'

    check 'crawling1'

    click_button 'Eintragen'

    expect(current_path).to eql league_path('the-league')
    expect(page).to have_content 'Das Spiel wurde eingetragen!'
    expect(page).to have_content 'Player 1'
    expect(page).to have_content 'Player 2'
    expect(page).to have_content 'Player 3'
    expect(page).to have_content 'Player 4'
    expect(page).to have_content '6:3'
    expect(page).to have_content '7:5'
    expect(page).to have_content 'Hier musste jemand krabbeln! Das sollte die Welt erfahren.'
  end
end
