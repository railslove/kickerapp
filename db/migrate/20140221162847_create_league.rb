# frozen_string_literal: true

class CreateLeague < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    add_column :teams, :league_id, :integer
    add_column :matches, :league_id, :integer
    add_column :users, :league_id, :integer
  end
end
