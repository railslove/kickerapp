class AddMatchesCounterCacheIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :leagues, :matches_count
  end
end
