# frozen_string_literal: true

class RenameQuoteToQuota < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :quote, :quota
  end
end
