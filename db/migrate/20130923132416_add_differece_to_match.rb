class AddDiffereceToMatch < ActiveRecord::Migration[4.2]
  def change
    add_column :matches, :difference, :integer, default: 0
  end
end
