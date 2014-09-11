namespace :users do
  desc 'Reset user quotas to 1200 and calculate quotas'
  task :set_stats => :environment do

    users = User.all
    users.each do |user|
      matches = user.matches
      p user.name
      user.number_of_crawls = matches.select{|m| m.crawling? && m.win_for?(user)}.count
      user.number_of_crawlings = matches.select{|m| m.crawling? && !m.win_for?(user)}.count
      wins = 0
      win = true
      while win == true do
        if matches[wins] && matches[wins].win_for?(user)
          wins +=1
        else
          win = false
        end
      end
      user.winning_streak = wins
      user.save
      p user.winning_streak
    end
  end

  task :calculate_longest_streak => :environment do
    users = User.all
    users.each do |user|
      p user.name
      matches = user.matches.unscoped
      current_winning_streak = 0
      matches.each do |match|
        if match.win_for?(user)
          current_winning_streak += 1
          if current_winning_streak > user.longest_winning_streak_games
            user.longest_winning_streak_games = current_winning_streak
          end
        else
          current_winning_streak = 0
        end
      end
      user.save
      p user.longest_winning_streak_games
    end
  end

  desc "Set Badges"
  task :set_badges => :environment do
    League.all.each do |league|
      league.update_badges
    end
  end
end
