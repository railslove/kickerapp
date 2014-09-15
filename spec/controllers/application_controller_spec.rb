require 'spec_helper'

describe ApplicationController, type: :controller do

  specify 'default_url_options' do
    expect(controller.default_url_options).to eql({ locale: I18n.locale })
  end

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

end
