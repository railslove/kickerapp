class AddMatchesCountToLeagues < ActiveRecord::Migration[4.2]
  def change
    add_column :leagues, :matches_count, :integer, default: 0
  end
end
