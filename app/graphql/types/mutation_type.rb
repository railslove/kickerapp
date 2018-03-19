Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  field :addPlayer, Types::UserType do
    description "Creates a user"
    argument :leagueSlug, !types.String
    argument :name, !types.String
    argument :email, !types.String
    argument :image, types.String

    resolve ->(o,args,c) {
      league = League.find_by(slug: args[:leagueSlug])
      league.users.create(name: args[:name], email: args[:email], image: args[:image])
    }
  end
  field :shuffle, !types[Types::TeamType] do
    argument :player1_id, !types.Int, prepare: -> (player1_id, ctx) { player1_id }
    argument :player2_id, !types.Int, prepare: -> (player2_id, ctx) { player2_id }
    argument :player3_id, !types.Int, prepare: -> (player3_id, ctx) { player3_id }
    argument :player4_id, !types.Int, prepare: -> (player4_id, ctx) { player4_id }
    resolve -> (obj, args, ctx) {
      Team.shuffle([args[:player1_id], args[:player2_id], args[:player3_id], args[:player4_id]])
    }
  end
end
