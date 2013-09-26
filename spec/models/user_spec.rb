require 'spec_helper'

describe User do
  describe "scopes" do
    describe "ranked" do
      it "sorts by quote desc" do
        good_user = FactoryGirl.create(:user, quote: 1400)
        bad_user = FactoryGirl.create(:user, quote: 1000)
        medium_user = FactoryGirl.create(:user, quote: 1200)
        expect(User.ranked).to eq([good_user, medium_user, bad_user])
      end
    end
  end

  describe ".number_of_games" do
    it "adds up wins and looses" do
      user = FactoryGirl.build(:user, number_of_wins: 3, number_of_looses: 7)
      expect(user.number_of_games).to eq(10)
    end
  end

  describe ".win_percentage" do
    it "takes the QuoteCalculator" do
      user = FactoryGirl.build(:user, number_of_wins: 3, number_of_looses: 7)
      QuoteCalculator.stub(:win_loose_quote).and_return(20)
      expect(user.win_percentage).to eq(20)
    end
  end

  describe ".set_elo_quote" do
    context "win" do
      before do
        QuoteCalculator.stub(:elo_quote).and_return(5)
      end
      it "calculates without crawling" do
        match = double(win_for?: true, winner_team: double("w_team", elo_quote: 1200), looser_team: double("l_team", elo_quote: 1200), crawling: false, difference: 5)
        subject.set_elo_quote(match)
        expect(subject.quote).to eql(1205)
      end
      it "calculates with crawling (+5)" do
        match = double(win_for?: true, winner_team: double("w_team", elo_quote: 1200), looser_team: double("l_team", elo_quote: 1200), crawling: true, difference: 5)
        subject.set_elo_quote(match)
        expect(subject.quote).to eql(1210)
      end
      it "updates the difference on a match" do
        match = FactoryGirl.create(:match, winner_team: FactoryGirl.create(:team), looser_team: FactoryGirl.create(:team))
        Team.any_instance.stub(:elo_quote).and_return(1200)
        subject.set_elo_quote(match)
        expect(match.difference).to eql(5)
      end
    end
    context "loose" do
      before do
        QuoteCalculator.stub(:elo_quote).and_return(-5)
      end
      it "calculates without crawling" do
        match = double(win_for?: false, winner_team: double("w_team", elo_quote: 1200), looser_team: double("l_team", elo_quote: 1200), crawling: false, difference: 5)
        subject.set_elo_quote(match)
        expect(subject.quote).to eql(1195)
      end
    end
  end
end
