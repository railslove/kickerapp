class AddTournamentToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.belongs_to :tournament 
    end
  end
end
