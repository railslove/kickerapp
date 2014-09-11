require 'spec_helper'

describe LeaguesController, type: :controller do

  describe '#create' do

    context 'successful' do
      before { expect(AdminMailer).to receive_message_chain(:new_league, :deliver) }

      specify do
        post :create, league: { name: 'Hammerwerfers Bockenbruch!', slug: 'Hammerwerfers Bockenbruch!' }
        expect(response).to redirect_to league_path(League.last)
        expect(flash[:notice]).to eql I18n.t('leagues.create.success')
      end
    end

    context 'unsuccessful' do
      specify do
        post :create, league: { name: 'Hammerwerfers Bocklemünd', slug: nil }
        expect(response).to be_success
        expect(response).to render_template 'leagues/new'
        expect(flash[:alert]).to eql I18n.t('leagues.create.failure')
      end
    end

  end

end
