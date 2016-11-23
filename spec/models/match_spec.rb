require 'spec_helper'

describe Match, type: :model do

  describe "#create_from_set" do
    before do
      @users = FactoryGirl.create_list(:user, 4)
      @set_params = {
        score: ["8", "10"],
        crawling: true,
        team1: { player1: @users[0].id.to_s, player2: @users[1].id.to_s },
        team2: { player1: @users[2].id.to_s, player2: @users[3].id.to_s }
      }
    end

    it "creates a new match" do
      expect(Match.count).to eql(0)
      expect(Match.create_from_set(@set_params)).to eq(Match.last)
    end

    it "assignes the correct teams" do
      match = Match.create_from_set(@set_params)
      expect(match.score).to eql("10:8")
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

  describe '.revert_points' do
    before do
      @loser_player = FactoryGirl.create(:user)
      @winner_player = FactoryGirl.create(:user)
      @winner_team = FactoryGirl.create(:team, number_of_wins: 5, player1: @loser_player)
      @loser_team = FactoryGirl.create(:team, number_of_losses: 5, player1: @winner_player)
      @match = Match.create(difference: 5, winner_team: @winner_team, loser_team: @loser_team)
    end

    it 'subtracts the difference for the winner team' do
      @match.reload.destroy
      expect(@winner_team.player1.reload.quota).to eq(1200)
    end

    it 'adds the difference for the loser team' do
      @match.reload.destroy
      expect(@loser_team.player1.reload.quota).to eq(1200)
    end

    it 'updates the counts for the teams' do
      @match.reload.destroy
      expect(@winner_team.reload.number_of_wins).to eq(0)
      expect(@loser_team.reload.number_of_losses).to eq(0)
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

  describe 'team_players_validation' do
    it 'validates that players from both teams are different' do
      @players = FactoryGirl.create_list(:user, 4)
      @match = Match.new
      @match.winner_team = FactoryGirl.create(:team, player1: @players[0], player2: @players[1])
      @match.loser_team = FactoryGirl.create(:team, player1: @players[1], player2: @players[3])
      expect(@match.valid?).to eq(false)
    end
  end
end
