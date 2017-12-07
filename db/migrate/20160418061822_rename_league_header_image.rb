# frozen_string_literal: true

class RenameLeagueHeaderImage < ActiveRecord::Migration
  def change
    rename_column :leagues, :league_header_image, :header_image
  end
end
