class AddLeagueHeaderImageToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :league_header_image, :string
  end
end
