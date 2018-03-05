# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

7.times do
  # create league
  puts "create league"
  liga = League.create({
    name: Faker::Space.galaxy,
    slug: Faker::Internet.slug,
    contact_email: Faker::Internet.safe_email
  })

  # create users
  puts "  create users"
  15.times do
    User.create({
      name: Faker::Name.name,
      email: Faker::Internet.safe_email,
      image: 'https://flathash.com/' + Faker::Internet.slug,
      league: liga
    })
  end

  # create teams
  puts "  create teams"
  30.times do
    Team.where({
      player1: liga.users.order("RANDOM()").first,
      player2: liga.users.order("RANDOM()").first,
      league: liga
    }).first_or_create
  end

  # create matches
  puts "  create matches"
  100.times do
    Match.create({
      league: liga,
      winner_team: liga.teams.order("RANDOM()").first,
      loser_team: liga.teams.order("RANDOM()").first,
      crawling: Faker::Boolean.boolean(0.2),
      score: "#{Faker::Number.between(0, 5)}:#{Faker::Number.between(0, 5)}",
      date: DateTime.now
    })
  end
end

