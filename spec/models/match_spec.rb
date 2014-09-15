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

  describe ".revert_points" do
    before do
      @match = Match.new(difference: 5)
      @match.winner_team = FactoryGirl.create(:team, number_of_wins: 5)
      @match.loser_team = FactoryGirl.create(:team, number_of_losses: 5)
      @match.save
    end

    it 'subtracts the difference for the winner team' do
      @match.winner_team.player1 = FactoryGirl.create(:user)
      @match.loser_team.player1 = FactoryGirl.create(:user)
      @match.revert_points
      expect(@match.winner_team.users.select{|u| u.quota == 1192}.count).to eq(1)
    end

    it 'adds the difference for the loser team' do
      @match.winner_team.player1 = FactoryGirl.create(:user)
      @match.loser_team.player1 = FactoryGirl.create(:user)
      @match.revert_points
      expect(@match.loser_team.users.select{|u| u.quota == 1208}.count).to eq(1)
    end

    it "updates the counts for the teams" do
      @match.loser_team.player1 = FactoryGirl.create(:user)
      @match.winner_team.player1 = FactoryGirl.create(:user)
      @match.revert_points
      expect(@match.winner_team.number_of_wins).to eq(5)
      expect(@match.loser_team.number_of_losses).to eq(5)
    end
  end

  describe ".swap_teams" do
    it "swaps winner and loser team" do
      @match = Match.new(difference: 5)
      team_1 = FactoryGirl.create(:team)
      team_2 = FactoryGirl.create(:team)
      @match.winner_team = team_1
      @match.loser_team = team_2
      @match.swap_teams
      expect(@match.winner_team).to eq(team_2)
    end
  end
end
