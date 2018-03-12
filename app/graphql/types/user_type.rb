Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, !types.ID
  field :quota, !types.Int
  field :name, !types.String
end
