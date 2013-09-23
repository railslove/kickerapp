require 'spec_helper'

describe Match do
  describe "#create_from_set" do
    before do
      @users = []
      @set_params = {crawling: true}
      4.times do |i|
        user = FactoryGirl.create(:user)
        @users << user
        @set_params[user.id] = i < 2 ? 3 : 6
      end
    end

    it "creates a new match" do
      expect(Match.count).to eql(0)
      expect(Match.create_from_set(@set_params)).to eq(Match.last)
    end

    it "creates teams if nessesary" do
      Match.create_from_set(@set_params)
      team = Team.for_users(@users[0], @users[1])
      team = Team.for_users(@users[2], @users[3])
      expect(Team.count).to eql(2)
    end

  end

  describe ".score_for_set" do
    specify { expect(subject.score_for_set(6,2)).to eq("6:2") }
  end

  describe ".crawling_for_set" do
    specify { expect(subject.crawling_for_set(crawling: true)).to eq(true) }
  end
end
