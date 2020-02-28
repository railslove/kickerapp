# frozen_string_literal: true

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
    argument :scores, types[ScoreInputType]
    resolve ->(_obj, args, _ctx) {
      league = League.find_by!(slug: args[:leagueSlug])
      team1 = Team.find_or_create_by(player1_id: args[:player1_id], player2_id: args[:player2_id])
      team2 = Team.find_or_create_by(player1_id: args[:player3_id], player2_id: args[:player4_id])
      matches = []
      args[:scores].each do |scores|
        if scores[:score1] > scores[:score2]
          match = league.matches.create(crawling: scores[:crawling], winner_team: team1, loser_team: team2, date: Time.now, score: "#{scores[:score1]}:#{scores[:score2]}")
        elsif scores[:score1] < scores[:score2]
          match = league.matches.create(crawling: scores[:crawling], winner_team: team2, loser_team: team1, date: Time.now, score: "#{scores[:score2]}:#{scores[:score1]}")
        end
        matches << match
      end
      DayMatch.create_and_calculate(matches, league)
    }
  end

  ScoreInputType = GraphQL::InputObjectType.define do
    name 'ScoreInputType'
    argument :score1, !types.Int do
      description 'HomeTeam Score'
    end

    argument :score2, !types.Int do
      description 'GuestTeam Score'
    end

    argument :crawling, !types.Boolean do
      description 'crawling'
    end
  end
end
