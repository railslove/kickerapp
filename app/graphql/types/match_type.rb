Types::MatchType = GraphQL::ObjectType.define do
  name 'Match'
  field :id, !types.ID
  field :score, !types.String
  field :crawling, !types.Boolean do
    resolve ->(obj, args, ctx) {
      obj.crawling.present?
    }
  end
  field :difference, !types.Int
  field :winner_team_id, !types.Int
  field :loser_team_id, !types.Int
  field :winner_team, !Types::TeamType
  field :loser_team, !Types::TeamType
  field :date, !types.String
end
