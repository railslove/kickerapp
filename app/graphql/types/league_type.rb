Types::LeagueType = GraphQL::ObjectType.define do
  name 'League'

  field :id, !types.ID
  field :slug, !types.String
  field :name, !types.String
  field :matches_count, types.Int
  field :longest_winning_streak, Types::UserType
  field :longest_winning_streak_ever, Types::UserType
  field :top_crawler, Types::UserType
  field :worst_crawler, Types::UserType
  field :matches, types[Types::MatchType] do
    argument :limit, types.Int, default_value: 30, prepare: -> (limit, ctx) { [limit, 50].min }
    resolve ->(obj, args, ctx) {
      obj.matches.first(args[:limit])
    }
  end
  field :day_matches, types[Types::DayMatchType] do
    argument :limit, types.Int, default_value: 50, prepare: -> (limit, ctx) { [limit, 100].min }
    resolve ->(obj, args, ctx) {
      obj.day_matches.order(created_at: :desc).first(args[:limit])
    }
  end
  field :ranking, types[Types::UserType] do
    resolve ->(obj, args, ctx) {
      obj.active_user_ranking
    }
  end
  
  field :users, types[Types::UserType] do
    resolve ->(obj, args, ctx) {
      obj.users.order(updated_at: :desc)
    }
  end
  field :teams, types[Types::TeamType] do
    resolve ->(obj, args, ctx) {
      obj.team_ranking.first(100)
    }
  end
end
