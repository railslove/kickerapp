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
end
