namespace :quote do
  desc "Calculate for all matches"
  task :calculate_all => :environment do
   puts "#{Time.now.utc} <- Starting all events before time"
   Match.all.each do |match|
     puts "Match #{match.id} started"
     match.calculate_user_quotes
   end
  end
  desc "Substract points for inactive players"
  task :weekly_substraction => :environment do
   User.all.each do |user|
    last_match = user.matches.any? ? (Date.today - user.matches.first.created_at.to_date).to_i : 0
    if last_match > 100 && user.quote > 1010
      old = user.quote
      user.quote = old - 2
      user.save
      p "#{user.name} lost 2 points (#{old} - #{user.quote})"
    end
   end
  end
end
