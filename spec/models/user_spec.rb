require 'spec_helper'

describe User do
  describe "scopes" do
    describe "ranked" do
      it "sorts by quota desc" do
        good_user = FactoryGirl.create(:user, quota: 1400)
        bad_user = FactoryGirl.create(:user, quota: 1000)
        medium_user = FactoryGirl.create(:user, quota: 1200)
        expect(User.ranked).to eq([good_user, medium_user, bad_user])
      end
    end
  end

  describe ".number_of_games" do
    it "adds up wins and losses" do
      user = FactoryGirl.build(:user, number_of_wins: 3, number_of_losses: 7)
      expect(user.number_of_games).to eq(10)
    end
  end

  describe ".win_percentage" do
    it "takes the QuotaCalculator" do
      user = FactoryGirl.build(:user, number_of_wins: 3, number_of_losses: 7)
      QuotaCalculator.stub(:win_lose_quota).and_return(20)
      expect(user.win_percentage).to eq(20)
    end
  end

  describe ".set_elo_quota" do
    context "win" do
      before do
        QuotaCalculator.stub(:elo_quota).and_return(5)
      end
      it "calculates without crawling" do
        match = double(win_for?: true, winner_team: double("w_team", elo_quota: 1200), loser_team: double("l_team", elo_quota: 1200), crawling: false, difference: 5)
          subject.set_elo_quota(match)
        expect(subject.quota).to eql(1205)
        expect(subject.winning_streak).to eql(1)
      end
      it "calculates with crawling (+5)" do
        match = double(win_for?: true, winner_team: double("w_team", elo_quota: 1200), loser_team: double("l_team", elo_quota: 1200), crawling: true, difference: 10)
        subject.set_elo_quota(match)
        expect(subject.quota).to eql(1210)
        expect(subject.number_of_crawls).to eql(1)
      end
      it "updates the difference on a match" do
        match = FactoryGirl.create(:match, winner_team: FactoryGirl.create(:team), loser_team: FactoryGirl.create(:team))
        Team.any_instance.stub(:elo_quota).and_return(1200)
        subject.set_elo_quota(match)
        expect(match.difference).to eql(5)
      end
    end
    context "lose" do
      before do
        QuotaCalculator.stub(:elo_quota).and_return(-5)
      end
      it "calculates without crawling" do
        match = double(win_for?: false, winner_team: double("w_team", elo_quota: 1200), loser_team: double("l_team", elo_quota: 1200), crawling: false, difference: 5)
        subject.set_elo_quota(match)
        expect(subject.quota).to eql(1195)
      end
    end
  end

  describe ".active?" do
    let!(:user) { FactoryGirl.create(:user, number_of_wins: 3, number_of_losses: 7) }
    let!(:user2) { FactoryGirl.create(:user, number_of_wins: 3, number_of_losses: 7) }
    let!(:team) { FactoryGirl.create(:team, player1_id: user.id) }
    let!(:team2) { FactoryGirl.create(:team, player1_id: user2.id) }
    let!(:match) { FactoryGirl.create(:match, winner_team_id: team.id, loser_team_id: team2.id, date: 1.week.ago) }
    context "is active" do
      specify do
        expect(user.active?).to eql(true)
      end
    end

    context 'not active' do
      it "has no matches" do
        team.update_attribute(:player1_id, nil)
        expect(user.active?).to eql(false)
      end

      it 'has old matches' do
        match.update_attribute(:date, 3.weeks.ago)
        expect(user.active?).to eql(false)
      end
    end
  end

  describe ".short_name" do
    let(:user) {FactoryGirl.build(:user, name: nil)}
    context "empty name" do
      specify{ expect(user.short_name).to eq('') }
    end
    context "name without whitespace" do
      specify do
        user.name = 'something'
        expect(user.short_name).to eq('so')
      end
    end
    context "name with at least one whitespace" do
      specify do
        user.name = 'Clark Kent'
        expect(user.short_name).to eq('CK')
      end
    end
  end
end
