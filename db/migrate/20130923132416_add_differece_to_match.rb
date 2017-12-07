# frozen_string_literal: true

class AddDiffereceToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :difference, :integer, default: 0
  end
end
