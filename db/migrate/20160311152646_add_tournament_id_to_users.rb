class AddTournamentIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tournament_id, :integer
  end
end
