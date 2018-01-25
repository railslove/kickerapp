class AddLeagueHeaderImageToLeagues < ActiveRecord::Migration[4.2]
  def change
    add_column :leagues, :league_header_image, :string
  end
end
