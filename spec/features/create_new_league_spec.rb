require 'spec_helper'

feature 'create new league' do

  scenario 'with correct entries' do
    visit(new_league_path)

    fill_in 'league_name', with: 'My New League'
    fill_in 'league_slug', with: 'new league'
    fill_in 'league_contact_email', with: 'me@example.com'

    click_button 'Liga anlegen'

    expect(current_path).to eql new_league_user_path('new-league')
    expect(page).to have_content 'Liga erfolgreich erzeugt!'
  end

  scenario 'with invalid entries' do
    visit(new_league_path)

    fill_in 'league_name', with: ''
    fill_in 'league_slug', with: ''
    fill_in 'league_contact_email', with: ''

    click_button 'Liga anlegen'

    expect(current_path).to eql leagues_path
    expect(page).to have_content 'Liga konnte nicht gespeichert werden.'
  end
end
