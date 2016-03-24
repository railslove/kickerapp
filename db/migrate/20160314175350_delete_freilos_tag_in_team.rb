class DeleteFreilosTagInTeam < ActiveRecord::Migration
  def change
    remove_column :teams, :is_free_ticket, :boolean, default: false
  end
end
