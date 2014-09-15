class AddMatchesCountToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :matches_count, :integer, default: 0
  end
end
