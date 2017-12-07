# frozen_string_literal: true

require 'spec_helper'

describe League, type: :model do
  describe 'scopes' do
    specify '.by_matches' do
      expect(League.by_matches.to_sql).to eql 'SELECT "leagues".* FROM "leagues"  ORDER BY matches_count DESC'
    end
  end

  describe 'sanitize_slug' do
    let(:league) { create :league, slug: 'Hammerboyz! da  heim' }

    specify do
      expect(league.slug).to eql 'hammerboyz-da-heim'
    end
  end

  describe 'create' do
    it 'does not allow duplicated ' do
      FactoryGirl.create(:league, slug: 'test')
      expect { FactoryGirl.create(:league, slug: 'Test') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
