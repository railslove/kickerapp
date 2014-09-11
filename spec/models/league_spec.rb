require 'spec_helper'

describe League do

  describe 'sanitize_slug' do
    let(:league) { create :league, slug: 'Hämmerboyz! da  heim' }

    specify do
      expect(league.slug).to eql 'haemmerboyz-da-heim'
    end
  end

end
