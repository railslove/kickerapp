# frozen_string_literal: true

namespace :users do
  desc 'Reset user quotas to 1200 and calculate quotas'
  task set_stats: :environment do
    users = User.all
    users.each do |user|
      matches = user.matches
      p user.name
      user.number_of_crawls = matches.select { |m| m.crawling? && m.win_for?(user) }.count
      user.number_of_crawlings = matches.select { |m| m.crawling? && !m.win_for?(user) }.count
      wins = 0
      win = true
      while win == true
        if matches[wins]&.win_for?(user)
          wins += 1
        else
          win = false
        end
      end
      user.winning_streak = wins
      user.save
      p user.winning_streak
    end
  end

  task calculate_longest_streak: :environment do
    users = User.all
    users.each do |user|
      p user.name
      user.calculate_longest_streak!
      p user.longest_winning_streak_games
    end
  end

  desc 'Set Badges'
  task set_badges: :environment do
    League.all.each(&:update_badges)
  end
end
