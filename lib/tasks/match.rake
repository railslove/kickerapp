namespace :match do
  desc 'Reset user quotes to 1200 and calculate quotes'
  task :recalculate => :environment do
    User.all.each do |user|
      user.quote = 1200
      user.number_of_wins = 0
      user.number_of_looses = 0
      user.save
    end
    Match.order("date ASC").each do |match|
      match.calculate_user_quotes
      p match.difference
    end
  end
end
