class AddTableNrToNewMatches < ActiveRecord::Migration
  def change
    add_column :new_matches, :table_nr, :integer
  end
end
