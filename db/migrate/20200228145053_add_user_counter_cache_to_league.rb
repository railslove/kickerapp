# frozen_string_literal: true

class AddUserCounterCacheToLeague < ActiveRecord::Migration[5.1]
  def change
    add_column :leagues, :users_count, :integer, default: 0, index: true
  end
end
