require 'spec_helper'

describe KpiCalculator do
  before do
    start_time = Time.local(2018,12,28)
    Timecop.freeze(start_time + 9.weeks)
    l1 = FactoryBot.create(:league, name: 'Test', created_at: start_time)
    8.times{|i|FactoryBot.create(:match, league: l1, date: start_time+i.weeks)}

    l2 = FactoryBot.create(:league, name: 'Test2', created_at: start_time + 3.weeks)
    5.times{|i|FactoryBot.create(:match, league: l2, date: start_time + 3.weeks + i.weeks)}

    l3 = FactoryBot.create(:league, name: 'Test3', created_at: start_time + 4.weeks)
    2.times{|i|FactoryBot.create(:match, league: l3, date: start_time + 4.weeks + i.weeks)}
  end

  after do
    Timecop.return
  end
  describe '#active_league_count' do
    it "calculates as many weeks as it is asked to" do
      expect(KpiCalculator.new(4).active_league_count(1).size).to eq(4)
    end

    it "calculates the active leagues per calendar week" do
      # all leagues from the before block are counted
      expect(KpiCalculator.new(8).active_league_count(1)).to eq([[1,1], [2,1], [3,1], [4,2], [5,3], [6,3], [7,2], [8,2]])
    end

    it "only leagues with a minimum amount of matches per week are considered" do
      # Just the league l1 is counted because it is the only one with more than 6 matches
      expect(KpiCalculator.new(8).active_league_count(6)).to eq([[1,1], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1], [8,1]])
    end
  end
end
