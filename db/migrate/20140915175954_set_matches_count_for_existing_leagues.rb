# frozen_string_literal: true

class SetMatchesCountForExistingLeagues < ActiveRecord::Migration
  def up
    League.find_each do |league|
      League.reset_counters(league.id, :matches)
    end
  end
end
