require 'spec_helper'

feature 'create new user' do
  let!(:league) { FactoryGirl.create(:league, name: 'The League', slug: 'the-league') }

  context 'using manual registration' do
    it 'with correct entries' do
      visit new_league_user_path('the-league')

      fill_in 'user_name', with: 'Karl Kicker'
      fill_in 'user_email', with: 'karl@example.com'
      fill_in 'user_image', with: 'http://example.com/image.jpg'

      click_button I18n.t('users.new.submit')

      expect(current_path).to eql new_league_match_path('the-league')
      expect(page).to have_content I18n.t('users.create.success', user_name: 'Karl Kicker', league_name: 'The League')
    end

    it 'with invalid entries' do
      pending 'not yet implemented'
      visit new_league_user_path('the-league')

      fill_in 'user_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_image', with: ''

      click_button I18n.t('users.new.submit')

      expect(current_path).to eql new_league_user_path('the-league')
      expect(page).to have_content I18n.t('users.create.failure')
    end
  end

  context 'using facebook' do
    it 'with valid credentials' do
      set_omniauth({provider: :facebook})

      visit league_path('the-league') #workaround to save the league in the session

      visit new_league_user_path('the-league')
      find('.m-button_facebook').click

      expect(current_path).to eql new_league_match_path('the-league')
      expect(page).to have_content I18n.t('users.create.success', user_name: 'Karl Facebook', league_name: 'The League')
    end
  end
end
