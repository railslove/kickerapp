class CreateUserTeams < ActiveRecord::Migration
  def change
    create_table :teams_users, :id => false do |t|

      t.integer :user_id
      t.integer :team_id
    end
  end
end
