require 'spec_helper'

describe MatchesController, type: :controller do

  describe '#create' do
    let(:league) { FactoryGirl.create(:league) }
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }

    specify do
      post :create, { league_id: league.slug, team1: [ user.id.to_s, '' ], team2: [ user2.id.to_s, ''], set1: ['6', '3'], set2: ['7','5'], set3: ['',''] }
      expect(response).to redirect_to league_path(league)
    end

    it 'redirects to new_league_match if mobile' do
      allow(subject).to receive(:is_mobile_device?).and_return(true)
      post :create, { league_id: league.slug, team1: [ user.id.to_s, '' ], team2: [ user2.id.to_s, ''], set1: ['6', '3'], set2: ['7','5'], set3: ['',''] }
      expect(response).to redirect_to new_league_match_path(league, team1: [ user.id.to_s, '' ], team2: [ user2.id.to_s, ''], created: true)
    end
  end

  describe '#update' do

  end

end
