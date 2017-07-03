# encoding: utf-8

require 'spec_helper'

describe LeaguesController, type: :controller do

  describe '#create' do

    context 'successful' do
      before do
        expect(controller).to receive(:set_current_league).with('hammerwerfers-bockenbruch')
      end

      specify do
        post :create, league: { name: 'Hammerwerfers Bockenbruch!', slug: 'Hammerwerfers Bockenbruch!', contact_email: 'contact@hammerwerfer.de' }
        expect(response).to redirect_to new_league_user_path('hammerwerfers-bockenbruch')
        expect(flash[:notice]).to eql I18n.t('leagues.create.success')
      end
    end

    context 'unsuccessful' do
      specify do
        FactoryGirl.create(:league, slug: 'test')
        post :create, league: { name: 'Hammerwerfers Bocklemünd', slug: 'test' }
        expect(response).to be_success
        expect(response).to render_template 'leagues/new'
        expect(flash[:alert]).to eql I18n.t('leagues.create.failure')
      end
    end

  end

  describe 'index' do
    let(:league1) { FactoryGirl.create(:league, slug: 'league1') }
    let(:league2) { FactoryGirl.create(:league, slug: 'league2') }
    before do
      session[:league_slug] = 'the-league'
      get :index
    end
    it{ expect(session[:league_slug]).to be_nil }
    it{ expect(assigns[:leagues]).to match_array [league1, league2] }
  end

  describe 'new' do
    before { get :new }
    it{ expect(response).to be_success }
    it{ expect(response).to render_template 'leagues/new' }
  end

  describe 'show' do
    let!(:league) { FactoryGirl.create(:league, slug: 'the-league') }
    let(:match1) { FactoryGirl.create(:match, league: league) }
    let(:match2) { FactoryGirl.create(:match, league: league) }
    context 'simple cases' do
      before do
        expect(controller).to receive(:set_current_league).with('the-league')
        get :show, id: 'the-league'
      end
      it{ expect(response).to be_success }
      it{ expect(response).to render_template 'leagues/show' }
      it{ expect(assigns[:league]).to eql league }
      it{ expect(assigns[:matches]).to include match1 }
      it{ expect(assigns[:matches]).to include match2 }
    end
    it 'marks a newly added crawling_match' do
      get :show, id: 'the-league', crawl_id: match1.id
      expect(assigns[:crawling_match]).to eql(match1)
    end
  end

  describe 'badges' do
    let!(:league) { FactoryGirl.create(:league, slug: 'the-league') }
    before do
      expect(controller).to receive(:set_current_league).with('the-league')
      get :badges, id: 'the-league'
    end
    it{ expect(response).to be_success }
    it{ expect(response).to render_template 'leagues/badges' }
    it{ expect(assigns[:league]).to eql league }
  end

end
