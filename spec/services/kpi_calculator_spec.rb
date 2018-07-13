require 'spec_helper'

describe KpiCalculator do
  before do
    start_time = Time.local(2018)
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
    it "calculates the active leagues per calendar week" do
      result = [[1,1], [2,1], [3,1], [4,2], [5,3], [6,3], [7,2], [8,2]]
      expect(KpiCalculator.new(8).active_league_count(1)).to eq(result)
    end
  end
end
