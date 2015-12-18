class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :skill_level, :integer
    add_column :users, :position, :string
  end
end
