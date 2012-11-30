class RemoveAttributesFromMatch < ActiveRecord::Migration
  def change
    create_table :match_scores do |t|
      t.integer :match_id
      t.integer :team_id
      t.integer :goals
      t.timestamps
    end
  end
end
