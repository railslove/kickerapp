require 'spec_helper'

describe ApplicationController, type: :controller do

  describe 'set_locale' do

    context 'reset to default locale' do
      before do
        allow(controller).to receive(:params).and_return({})
      end

      specify do
        I18n.locale = :es
        controller.send(:set_locale)
        expect(I18n.locale).to eql I18n.default_locale
      end
    end

    context 'change locale' do
      before do
        allow(controller).to receive(:params).and_return({ locale: 'en'})
      end

      specify do
        expect{ controller.send(:set_locale) }.to change{ I18n.locale }.from(I18n.default_locale).to(:en)
      end
    end
  end

  describe 'require_league' do
    controller do
      before_filter :require_league
      def index
        render text: 'welcome to your league'
      end
    end

    context 'current league is set' do
      before do
        allow(controller).to receive(:current_league).and_return(123)
      end
      it 'should not redirect' do
        get :index
        expect(response.body).to eq('welcome to your league')
      end
    end

    context 'current league is not set' do
      before do
        allow(controller).to receive(:current_league).and_return(nil)
      end
      it 'should redirect to root_path' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'current_league' do
    let!(:league) { create :league, slug: 'the-league' }

    context 'current league is set in session' do
      before do
        session[:league] = 'the-league'
      end
      it{ expect(controller.current_league).to eql league }
    end

    context 'current league is passed to params[:league_id]' do
      before do
        allow(controller).to receive(:params).and_return({ league_id: 'the-league' })
      end
      it{ expect(controller.current_league).to eql league }
    end

    context 'current league is passed to params[:id]' do
      before do
        allow(controller).to receive(:params).and_return({ id: 'the-league' })
      end
      it{ expect(controller.current_league).to eql league }
    end

    context 'current league is not set' do
      it{ expect(controller.current_league).to be_nil }
    end
  end

  describe 'clear_current_league' do
    before{ session[:league] = 'the-league' }
    it{ expect{ controller.send(:clear_current_league) }.to change{ session[:league] }.from('the-league').to(nil) }
  end

end
