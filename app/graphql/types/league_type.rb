Types::LeagueType = GraphQL::ObjectType.define do
  name 'League'

  field :id, !types.ID
  field :slug, !types.String
  field :name, !types.String
  field :matches_count, types.Int
  field :matches, types[Types::MatchType] do
    argument :limit, types.Int, default_value: 10, prepare: -> (limit, ctx) { [limit, 50].min }
    resolve ->(obj, args, ctx) {
      obj.matches.first(args[:limit])
    }
  end
  field :ranking, types[Types::UserType] do
    resolve ->(obj, args, ctx) {
      obj.active_user_ranking
    }
  end
  field :users, types[Types::UserType] do
    resolve ->(obj, args, ctx) {
      obj.users.order(quota: :desc)
    }
  end
  field :teams, types[Types::TeamType] do
    resolve ->(obj, args, ctx) {
      obj.team_ranking
    }
  end
end
