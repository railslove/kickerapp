require 'spec_helper'

describe KpiCalculator do
  let(:start_time) { Time.local(2018, 12, 28) }
  let(:league_1) { FactoryBot.create(:league, name: 'League_1', created_at: start_time) }
  let(:league_2) { FactoryBot.create(:league, name: 'League_2', created_at: start_time + 3.weeks) }
  let(:league_3) { FactoryBot.create(:league, name: 'League_3', created_at: start_time + 4.weeks) }

  before do
    Timecop.freeze(start_time + 9.weeks)

    (0..7).each { |i| FactoryBot.create(:match, league: league_1, date: start_time + i.weeks) }
    (0..4).each { |i| FactoryBot.create(:match, league: league_2, date: start_time + 3.weeks + i.weeks) }
    (0..1).each { |i| FactoryBot.create(:match, league: league_3, date: start_time + 4.weeks + i.weeks) }
  end

  after do
    Timecop.return
  end

  describe '#active_league_count' do
    it "calculates as many weeks as it is asked to" do
      expect(described_class.new(number_of_weeks: 4).active_league_count(1).size).to eq(4)
    end

    it "calculates the active leagues per calendar week" do
      # all leagues from the before block are counted
      expect(described_class.new(number_of_weeks: 8).active_league_count(1)).to eq(
        [[1,1], [2,1], [3,1], [4,2], [5,3], [6,3], [7,2], [8,2]]
      )
    end

    it "considers only leagues with a minimum amount of matches per week" do
      # Just the league l1 is counted because it is the only one with more than 6 matches
      expect(described_class.new(number_of_weeks: 9).active_league_count(6)).to eq(
        [[52,0], [1,1], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1], [8,1]]
      )
    end
  end
end
