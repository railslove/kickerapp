namespace :users do
  desc 'Reset user quotes to 1200 and calculate quotes'
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

  desc "Set Badges"
  task :set_badges => :environment do
    League.all.each do |league|
      league.update_badges
    end
  end
end
