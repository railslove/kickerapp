class AddFreilosTagToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :is_free_ticket, :boolean, default: false
  end
end
