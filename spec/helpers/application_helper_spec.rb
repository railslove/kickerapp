# frozen_string_literal: true

require 'spec_helper'

describe ApplicationHelper, type: :helper do
  describe '#other_locale' do
    specify 'for de' do
      expect(helper.other_locale(:de)).to eql :en
    end

    specify 'for en' do
      expect(helper.other_locale(:en)).to eql :de
    end

    context 'for any other locale' do
      before { allow(I18n).to receive(:default_locale).and_return :zh }
      specify do
        expect(helper.other_locale(:es)).to eql :zh
      end
    end
  end
end
