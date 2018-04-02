Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  field :addPlayer, Types::UserType do
    description 'Creates a user'
    argument :leagueSlug, !types.String
    argument :name, !types.String
    argument :email, !types.String
    argument :image, types.String

    resolve ->(_o, args, _c) {
      league = League.find_by(slug: args[:leagueSlug])
      league.users.create(name: args[:name], email: args[:email], image: args[:image])
    }
  end

  field :shuffle, types[Types::TeamType] do
    description 'Draws random teams'
    argument :player1_id, !types.Int
    argument :player2_id, !types.Int
    argument :player3_id, !types.Int
    argument :player4_id, !types.Int
    resolve ->(_obj, args, _ctx) {
      Team.shuffle([args[:player1_id], args[:player2_id], args[:player3_id], args[:player4_id]])
    }
  end

  field :addMatch, Types::MatchType do
    description 'Creates a new Match'
    argument :leagueSlug, !types.String
    argument :player1_id, !types.Int
    argument :player2_id, types.Int
    argument :player3_id, !types.Int
    argument :player4_id, types.Int
    argument :score_1, !types.Int
    argument :score_2, !types.Int
    resolve ->(_obj, args, _ctx) {
      league = League.find_by(slug: args[:leagueSlug])
      team1 = Team.find_or_create_by(player1_id: args[:player1_id], player2_id: args[:player2_id])
      team2 = Team.find_or_create_by(player1_id: args[:player3_id], player2_id: args[:player4_id])
      if args[:score_1] > args[:score_2]
        match = league.matches.create(winner_team: team1, loser_team: team2, date: Time.now, score: "#{args[:score_1]}:#{args[:score_2]}")
      elsif args[:score_1] < args[:score_2]
        match = league.matches.create(winner_team: team2, loser_team: team1, date: Time.now, score: "#{args[:score_2]}:#{args[:score_1]}")
      end
      match
    }
  end
end
