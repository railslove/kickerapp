require 'spec_helper'

feature 'create new league' do

  scenario 'with correct entries' do
    visit(new_league_path)

    fill_in 'league_name', with: 'My New League'
    fill_in 'league_slug', with: 'new league'
    fill_in 'league_contact_email', with: 'me@example.com'

    click_button I18n.t('leagues.new.create_league_submit')

    expect(current_path).to eql new_league_user_path('new-league')
    expect(page).to have_content I18n.t('leagues.create.success')
  end

  scenario 'with invalid entries' do
    visit(new_league_path)

    fill_in 'league_name', with: ''
    fill_in 'league_slug', with: ''
    fill_in 'league_contact_email', with: ''

    click_button I18n.t('leagues.new.create_league_submit')

    expect(current_path).to eql leagues_path
    expect(page).to have_content I18n.t('leagues.create.failure')
  end
end
