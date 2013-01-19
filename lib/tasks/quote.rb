namespace :quote do
  desc "Calculate for all matches"
  task :calculate_all => :environment do
   puts "#{Time.now.utc} <- Starting all events before time"
   Match.all.each do |match|
     puts "Match #{match.id} started"
     match.calculate_user_quotes
   end
  end
end
