class AddWinFlagToMatchScore < ActiveRecord::Migration
  def change
    add_column :match_scores, :win, :boolean
  end
end
