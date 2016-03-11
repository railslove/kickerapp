class CreateNewMatches < ActiveRecord::Migration
  def change
    create_table :new_matches do |t|
      t.integer :tournament_id
      t.integer :hometeam_id
      t.integer :awayteam_id
      t.integer :tournament_position
      t.integer :winner_next_match_position
    end
  end
end
