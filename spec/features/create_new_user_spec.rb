require 'spec_helper'

feature 'create new user' do
  let!(:league) { FactoryGirl.create(:league, name: 'The League', slug: 'the-league') }

  context 'using manual registration' do
    scenario 'with correct entries' do
      visit new_league_user_path('the-league')

      fill_in 'user_name', with: 'Karl Kicker'
      fill_in 'user_email', with: 'karl@example.com'
      fill_in 'user_image', with: 'http://example.com/image.jpg'

      click_button 'Spieler anlegen'

      expect(current_path).to eql new_league_match_path('the-league')
      expect(page).to have_content 'Karl Kicker ist der Liga The League beigetreten!'
    end

    scenario 'with invalid entries' do
      visit new_league_user_path('the-league')

      fill_in 'user_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_image', with: ''

      click_button 'Spieler anlegen'

      expect(current_path).to eql league_users_path('the-league')
      expect(page).to have_content 'Spieler konnte nicht gespeichert werden.'
    end
  end

  context 'using facebook' do
    scenario 'with valid credentials' do
      set_omniauth({
        provider: :facebook,
        uuid: '1234',
        facebook: {
          name: 'Karl Facebook',
          email: 'karl.facebook@example.com',
          image: 'http://example.com/facebook/karl.facebook.jpg'
        }
      })

      visit league_path('the-league') #workaround to save the league in the session

      visit new_league_user_path('the-league')
      find('.m-button_facebook').click

      expect(current_path).to eql new_league_match_path('the-league')
      expect(page).to have_content 'Karl Facebook ist der Liga The League beigetreten!'

      new_user = User.find_by_provider_and_uid_and_league_id('facebook', '1234', league.id)
      expect(new_user).to be_kind_of(User)
      expect(new_user.name).to eql 'Karl Facebook'
      expect(new_user.email).to eql 'karl.facebook@example.com'
      expect(new_user.image).to eql 'http://example.com/facebook/karl.facebook.jpg'
      expect(new_user.provider).to eql 'facebook'
      expect(new_user.uid).to eql '1234'
    end

    scenario 'with invalid credentials' do
      set_invalid_omniauth({ provider: :facebook })

      visit league_path('the-league') #workaround to save the league in the session

      visit new_league_user_path('the-league')
      find('.m-button_facebook').click

      expect(current_path).to eql new_league_user_path('the-league')
      expect(page).to have_content 'Registrierung per facebook ist fehlgeschlagen (invalid_crendentials)!'
    end
  end

  context 'using twitter' do
    scenario 'with valid credentials' do
      set_omniauth({
        provider: :twitter,
        uuid: '1234',
        twitter: {
          name: "Karl Twitter",
          email: "karl.twitter@example.com",
          image: "http://example.com/twitter/karl.twitter.jpg"
        }
      })

      visit new_league_user_path('the-league')
      find('.m-button_twitter').click

      expect(current_path).to eql new_league_match_path('the-league')
      expect(page).to have_content 'Karl Twitter ist der Liga The League beigetreten!'

      new_user = User.find_by_provider_and_uid_and_league_id('twitter', '1234', league.id)
      expect(new_user).to be_kind_of(User)
      expect(new_user.name).to eql 'Karl Twitter'
      expect(new_user.email).to eql 'karl.twitter@example.com'
      expect(new_user.image).to eql 'http://example.com/twitter/karl.twitter.jpg'
      expect(new_user.provider).to eql 'twitter'
      expect(new_user.uid).to eql '1234'
    end

    scenario 'with invalid credentials' do
      set_invalid_omniauth({ provider: :twitter })

      visit new_league_user_path('the-league')
      find('.m-button_twitter').click

      expect(current_path).to eql new_league_user_path('the-league')
      expect(page).to have_content 'Registrierung per twitter ist fehlgeschlagen (invalid_crendentials)!'
    end
  end
end
