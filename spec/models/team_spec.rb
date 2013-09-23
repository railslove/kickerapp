require 'spec_helper'

describe Team do
  describe "#find_or_create" do
    let(:team) { FactoryGirl.create(:team) }
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }

    it "fetches the correct team from the db" do
      team.player1 = user1
      team.player2 = user2
      team.save
      expect(Team.find_or_create([user1.id, user2.id])).to eq(team)
    end

    it 'creates a new team if it doesnt exist yet' do
      expect(Team.count).to eql(0)
      expect(Team.find_or_create([user1.id, user2.id])).to eq(Team.last)
    end
  end

  describe ".users" do
    let(:team) { FactoryGirl.create(:team) }
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }

    it "returns the correct users" do
      team.player1 = user1
      team.player2 = user2
      team.save
      expect(team.users).to include(user1)
      expect(team.users).to include(user2)
    end

    it "returns only one user for one player teams" do
      team.player2 = user2
      team.save
      expect(team.users).to eq([user2])
    end
  end
end
