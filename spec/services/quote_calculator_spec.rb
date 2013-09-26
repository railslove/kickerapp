require 'spec_helper'

describe QuoteCalculator do
  describe '#win_loose_quote' do
    it "return 0 if wins and looses are 0" do
      expect(QuoteCalculator.win_loose_quote(0, 0)).to eq(0)
    end
    it "calculates quote with wins bigger 0" do
      expect(QuoteCalculator.win_loose_quote(5, 0)).to eq(100)
    end

    it "calculates quote with looses bigger 0" do
      expect(QuoteCalculator.win_loose_quote(0, 5)).to eq(0)
    end

    it "calculates quote with both values bigger 0" do
      expect(QuoteCalculator.win_loose_quote(5, 5)).to eq(50)
    end
  end

  describe '#elo_quote' do
    context "win" do
      it "calculates difference accoding to ELO algorithmen" do
        expect(QuoteCalculator.elo_quote(1200, 1200, 1)).to eql(8)
      end

      it "calculates difference accoding to ELO algorithmen maximum 15 points" do
        expect(QuoteCalculator.elo_quote(0, 2000, 1)).to eql(15)
      end

      it "calculates difference accoding to ELO algorithmen minimum 1 points" do
        expect(QuoteCalculator.elo_quote(2000, 1, 1)).to eql(1)
      end
    end

    context "loose" do
      it "calculates difference accoding to ELO algorithmen" do
        expect(QuoteCalculator.elo_quote(1200, 1200, 0)).to eql(-8)
      end

      it "calculates difference accoding to ELO algorithmen maximum 16 points" do
        expect(QuoteCalculator.elo_quote(2000, 0, 0)).to eql(-16)
      end

      it "calculates difference accoding to ELO algorithmen minimum 1 points" do
        expect(QuoteCalculator.elo_quote(1, 2000, 0)).to eql(-1)
      end
    end
  end
end
