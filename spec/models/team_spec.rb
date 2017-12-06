# frozen_string_literal: true

require 'spec_helper'

describe Team, type: :model do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team, player1: user1) }
  let(:team2) { FactoryGirl.create(:team, player1: user2) }
  let!(:match) { FactoryGirl.create(:match, winner_team: team, loser_team: team2) }

  describe '#find_or_create' do
    it 'fetches the correct team from the db' do
      team.player1 = user1
      team.player2 = user2
      team.save
      expect(Team.find_or_create([user1.id, user2.id])).to eq(team)
    end

    it 'creates a new team if it doesnt exist yet' do
      expect(Team.find_or_create([user1.id, user2.id])).to eq(Team.last)
    end
  end

  describe '#shuffle' do
    it 'returns an empty array if not exactly 4 user ids present' do
      expect(Team.shuffle([1, 2, 3])).to eq([])
    end

    it 'selects two teams for four players' do
      user3 = FactoryGirl.create(:user, quota: 1400)
      user4 = FactoryGirl.create(:user, quota: 1000)
      teams = Team.shuffle([user1.id, user2.id, user3.id, user4.id])
      expect(teams.first.users).to include(user3)
    end
  end

  describe '.users' do
    context '2 players team' do
      let(:subject) { FactoryGirl.create(:team, player1: user1, player2: user2) }
      it { expect(subject.users).to match_array [user1, user2] }
    end
    context '1 player team' do
      let(:subject) { FactoryGirl.create(:team, player1: user2) }
      it { expect(subject.users).to match_array [user2] }
    end
  end

  describe '.elo_quota' do
    it 'adds up user quotas and divides correctly' do
      team.update_attributes(player1_id: user1.id, player2_id: user2.id)
      expect(team.elo_quota).to eql(((user1.quota + user2.quota) / 2).round)
    end
  end

  describe '.percentage' do
    let!(:match) { FactoryGirl.create(:match, winner_team_id: team.id, loser_team_id: team2.id) }
    context 'has games' do
      let(:team_percentage) { FactoryGirl.build(:team, number_of_wins: 2, number_of_losses: 2, player1_id: user1.id) }
      specify { expect(team_percentage.percentage).to eql(50) }
    end
    context 'no games' do
      let(:team_percentage) { FactoryGirl.build(:team, number_of_wins: 0, number_of_losses: 0, player1_id: user2.id) }
      specify { expect(team_percentage.percentage).to eql(0) }
    end
  end

  describe '.wins' do
    before do
      match.update_attributes(winner_team_id: team.id)
    end
    it 'shows only wins' do
      expect(team.wins.to_a).to eql([match])
    end
  end

  describe '.losses' do
    let!(:match2) { FactoryGirl.create(:match, winner_team: team2, loser_team: team) }
    it 'shows only wins' do
      expect(team.losses.to_a).to eql([match2])
    end
  end

  describe '.players_validation' do
    let!(:players) { FactoryGirl.build_list(:user, 2) }
    context 'team has one player' do
      let(:subject) { FactoryGirl.build(:team, player1: user1) }
      it { expect(subject.valid?).to eq(true) }
    end
    context 'team has two players' do
      let(:subject) { FactoryGirl.build(:team, player1: user1, player2: user2) }
      it { expect(subject.valid?).to eq(true) }
    end
    context 'team has no players' do
      let(:subject) { FactoryGirl.build(:team, player1: nil, player2: nil) }
      it { expect(subject.valid?).to eq(false) }
    end
  end
end
