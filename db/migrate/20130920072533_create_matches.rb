class CreateMatches < ActiveRecord::Migration[4.2]
  def change
    create_table :matches do |t|
      t.integer :winner_team_id
      t.integer :looser_team_id
      t.string :score
      t.boolean :crawling
      t.datetime :date
    end
  end
end
