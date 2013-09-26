require 'spec_helper'

describe Team do
  let(:team) { FactoryGirl.create(:team) }
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  describe "#find_or_create" do
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

  describe ".elo_quote" do
    it "adds up user quotes and divides correctly" do
      user1.update_attributes(quote: 1300)
      team.update_attributes(player1_id: user1.id, player2_id: user2.id)
      expect(team.elo_quote).to eql(((1300 + 1200)/ 2).round)
    end
  end
end
