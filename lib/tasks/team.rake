# frozen_string_literal: true

namespace :team do
  desc 'Reset user quotas to 1200 and calculate quotas'
  task set_elo: :environment do
    Team.all.each do |team|
      team.update_attribute(:quota, team.value)
    end
  end
end
