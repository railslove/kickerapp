require 'spec_helper'

describe QuotaCalculator do
  describe '#win_loose_quota' do
    it "return 0 if wins and looses are 0" do
      expect(QuotaCalculator.win_loose_quota(0, 0)).to eq(0)
    end
    it "calculates quota with wins bigger 0" do
      expect(QuotaCalculator.win_loose_quota(5, 0)).to eq(100)
    end

    it "calculates quota with looses bigger 0" do
      expect(QuotaCalculator.win_loose_quota(0, 5)).to eq(0)
    end

    it "calculates quota with both values bigger 0" do
      expect(QuotaCalculator.win_loose_quota(5, 5)).to eq(50)
    end
  end

  describe '#elo_quota' do
    context "win" do
      it "calculates difference accoding to ELO algorithmen" do
        expect(QuotaCalculator.elo_quota(1200, 1200, 1)).to eql(8)
      end

      it "calculates difference accoding to ELO algorithmen maximum 15 points" do
        expect(QuotaCalculator.elo_quota(0, 2000, 1)).to eql(15)
      end

      it "calculates difference accoding to ELO algorithmen minimum 1 points" do
        expect(QuotaCalculator.elo_quota(2000, 1, 1)).to eql(1)
      end
    end

    context "loose" do
      it "calculates difference accoding to ELO algorithmen" do
        expect(QuotaCalculator.elo_quota(1200, 1200, 0)).to eql(-8)
      end

      it "calculates difference accoding to ELO algorithmen maximum 16 points" do
        expect(QuotaCalculator.elo_quota(2000, 0, 0)).to eql(-16)
      end

      it "calculates difference accoding to ELO algorithmen minimum 1 points" do
        expect(QuotaCalculator.elo_quota(1, 2000, 0)).to eql(-1)
      end
    end
  end
end
