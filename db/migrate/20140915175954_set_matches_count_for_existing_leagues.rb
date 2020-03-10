# frozen_string_literal: true

class SetMatchesCountForExistingLeagues < ActiveRecord::Migration[4.2]
  def up
    League.find_each do |league|
      League.reset_counters(league.id, :matches)
    end
  end
end
