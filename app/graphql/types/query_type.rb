# frozen_string_literal: true

Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :leagues, !types[Types::LeagueType] do
    argument :limit, types.Int, default_value: 20, prepare: ->(limit, _ctx) { [limit, 100].min }
    argument :league_slug, types.String, prepare: ->(league_slug, _ctx) { league_slug }
    resolve ->(_obj, args, _ctx) {
      leagues = League.limit(args[:limit]).order(updated_at: :desc)
      leagues = leagues.where(slug: args[:league_slug]) if args[:league_slug].present?
      leagues
    }
  end
  

  field :players, Types::UserType do
    argument :id, types.Int, prepare: ->(id, _ctx) { id }
    resolve ->(_obj, args, _ctx) {
      User.find(args[:id])
    }
  end
end
