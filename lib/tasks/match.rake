namespace :match do
  desc 'Reset user quotas to 1200 and calculate quotas'
  task :recalculate => :environment do

    User.update_all(quota: 1200, number_of_wins: 0, number_of_looses: 0, number_of_crawls: 0, number_of_crawlings: 0, winning_streak: 0)
    Team.update_all(number_of_wins: 0, number_of_looses: 0)
    HistoryEntry.delete_all
    League.all.each do |league|
      Match.where(league_id: league.id).reorder("date ASC, id ASC").each do |match|
        p match.date, league.name
        match.calculate_user_quotas
        HistoryEntry.track(match)
        p match.difference
      end
      league.update_badges
    end
  end
end
