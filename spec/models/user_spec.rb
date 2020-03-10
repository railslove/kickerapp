# frozen_string_literal: true

require 'spec_helper'

describe User, type: :model do
  subject { FactoryBot.build(:user) }

  describe 'create' do
    %i[name image email].each do |field|
      it "handles very long inputs for #{field}" do
        subject.send("#{field}=", 'a' * 256)
        expect(subject).to_not be_valid
        expect(subject.errors[field].length).to eq(1)
      end
    end
  end

  describe 'scopes' do
    describe 'ranked' do
      it 'sorts by quota desc' do
        good_user = FactoryBot.create(:user, quota: 1400)
        bad_user = FactoryBot.create(:user, quota: 1000)
        medium_user = FactoryBot.create(:user, quota: 1200)
        expect(User.ranked).to eq([good_user, medium_user, bad_user])
      end
    end
  end

  describe '.number_of_games' do
    it 'adds up wins and losses' do
      user = FactoryBot.build(:user, number_of_wins: 3, number_of_losses: 7)
      expect(user.number_of_games).to eq(10)
    end
  end

  describe '.win_percentage' do
    it 'takes the QuotaCalculator' do
      user = FactoryBot.build(:user, number_of_wins: 3, number_of_losses: 7)
      allow(QuotaCalculator). to receive(:win_lose_quota).and_return(20)
      expect(user.win_percentage).to eq(20)
    end
  end

  describe '.set_elo_quota' do
    context 'win' do
      before do
        allow(QuotaCalculator).to receive(:elo_quota).and_return(5)
      end
      it 'calculates without crawling' do
        match = double(win_for?: true, winner_team: double('w_team', elo_quota: 1200), loser_team: double('l_team', elo_quota: 1200), crawling: false, difference: 5)
        allow(subject).to receive(:matches).and_return([double(win_for?: true)])
        subject.set_elo_quota(match)
        expect(subject.quota).to eql(1205)
      end
      it 'calculates with crawling (+5)' do
        match = double(win_for?: true, winner_team: double('w_team', elo_quota: 1200), loser_team: double('l_team', elo_quota: 1200), crawling: true, difference: 10)
        subject.set_elo_quota(match)
        expect(subject.quota).to eql(1210)
        expect(subject.number_of_crawls).to eql(2)
      end
      it 'updates the difference on a match' do
        match = FactoryBot.create(:match, winner_team: FactoryBot.create(:team), loser_team: FactoryBot.create(:team))
        allow_any_instance_of(Team).to receive(:elo_quota).and_return(1200)
        subject.set_elo_quota(match)
        expect(match.difference).to eql(5)
      end
    end
    context 'lose' do
      before do
        allow(QuotaCalculator).to receive(:elo_quota).and_return(-5)
      end
      it 'calculates without crawling' do
        match = double(win_for?: false, winner_team: double('w_team', elo_quota: 1200), loser_team: double('l_team', elo_quota: 1200), crawling: false, difference: 5)
        subject.set_elo_quota(match)
        expect(subject.quota).to eql(1195)
      end
    end
  end

  describe '.active?' do
    let!(:user) { FactoryBot.create(:user, number_of_wins: 3, number_of_losses: 7) }
    let!(:user2) { FactoryBot.create(:user, number_of_wins: 3, number_of_losses: 7) }
    let!(:team) { FactoryBot.create(:team, player1_id: user.id) }
    let!(:team2) { FactoryBot.create(:team, player1_id: user2.id) }
    let!(:match) { FactoryBot.create(:match, winner_team_id: team.id, loser_team_id: team2.id, date: 1.week.ago) }
    context 'is active' do
      specify do
        expect(user.active?).to eql(true)
      end
    end

    context 'not active' do
      it 'has no matches' do
        team.update_attribute(:player1_id, nil)
        expect(user.active?).to eql(false)
      end

      it 'has old matches' do
        match.update_attribute(:date, 3.weeks.ago)
        expect(user.active?).to eql(false)
      end
    end
  end

  describe '.short_name' do
    let(:user) { FactoryBot.build(:user, name: nil) }
    context 'empty name' do
      specify { expect(user.short_name).to eq('') }
    end
    context 'name without whitespace' do
      specify do
        user.name = 'something'
        expect(user.short_name).to eq('so')
      end
    end
    context 'name with at least one whitespace' do
      specify do
        user.name = 'Clark Kent'
        expect(user.short_name).to eq('CK')
      end
    end
  end

  describe '.calculate_current_streak!' do
    let!(:user) { FactoryBot.create(:user, number_of_wins: 3, number_of_losses: 7) }
    let!(:opponent) { FactoryBot.create(:user, number_of_wins: 3, number_of_losses: 7) }
    let!(:team) { FactoryBot.create(:team, player1_id: user.id) }
    let!(:team2) { FactoryBot.create(:team, player1_id: opponent.id) }

    context 'user just played his first game' do
      before do
        FactoryBot.create(:match, winner_team_id: team.id, loser_team_id: team2.id, date: 1.week.ago)
      end

      it 'calculates the current winning streak' do
        expect { user.calculate_current_streak! }.not_to change { user.winning_streak }
      end
    end

    context 'user lost last game' do
      before do
        FactoryBot.create(:match, winner_team_id: team.id, loser_team_id: team2.id, date: 2.minutes.ago)
        FactoryBot.create(:match, winner_team_id: team2.id, loser_team_id: team.id, date: 1.minute.ago)
      end

      it 'sets current streak to zero' do
        user.calculate_current_streak!
        expect(user.winning_streak).to eq(0)
      end

      it 'resets your previous streak' do
        user.update_attribute(:winning_streak, 10)
        expect { user.calculate_current_streak! }.to change { user.winning_streak }.from(10).to(0)
      end
    end
  end

  describe '.calculate_longest_streak!' do
    let!(:user) { FactoryBot.create(:user, number_of_wins: 3, number_of_losses: 7) }
    let!(:user2) { FactoryBot.create(:user, number_of_wins: 3, number_of_losses: 7) }
    let!(:team) { FactoryBot.create(:team, player1_id: user.id) }
    let!(:team2) { FactoryBot.create(:team, player1_id: user2.id) }
    let!(:match) { FactoryBot.create(:match, winner_team_id: team.id, loser_team_id: team2.id, date: 1.week.ago) }

    it 'calculates the longest winning streak' do
      expect { user.calculate_longest_streak! }.to change { user.longest_winning_streak_games }.from(0).to(1)
    end

    it 'doesn\'t change anything if you\'re a loser!' do
      expect { user2.calculate_longest_streak! }.not_to change { user2.longest_winning_streak_games }.from(0)
    end
  end
end
