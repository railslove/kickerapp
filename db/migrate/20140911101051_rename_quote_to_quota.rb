# frozen_string_literal: true

class RenameQuoteToQuota < ActiveRecord::Migration
  def change
    rename_column :users, :quote, :quota
  end
end
