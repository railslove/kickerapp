require 'spec_helper'

feature 'create new match' do
  let!(:league) { FactoryGirl.create(:league, name: 'The League', slug: 'the-league') }
  let!(:player1) { FactoryGirl.create(:user, name: 'Player 1', league: league) }
  let!(:player2) { FactoryGirl.create(:user, name: 'Player 2', league: league) }
  let!(:player3) { FactoryGirl.create(:user, name: 'Player 3', league: league) }
  let!(:player4) { FactoryGirl.create(:user, name: 'Player 4', league: league) }

  it '' do
    visit new_league_match_path('the-league')

    select 'Player 1', from: 'team1_player1'
    select 'Player 2', from: 'team1_player2'
    select 'Player 3', from: 'team2_player1'
    select 'Player 4', from: 'team2_player2'

    fill_in 'set1_team1', with: '6'
    fill_in 'set1_team2', with: '3'
    fill_in 'set2_team1', with: '7'
    fill_in 'set2_team2', with: '5'

    click_button I18n.t('matches.form.enter')

    expect(current_path).to eql league_path('the-league')
    expect(page).to have_content I18n.t('matches.create.success')
    expect(page).to have_content /Player 1/
    expect(page).to have_content /Player 2/
    expect(page).to have_content /Player 3/
    expect(page).to have_content /Player 4/
    expect(page).to have_content /6:3/
    expect(page).to have_content /7:5/
  end
end
