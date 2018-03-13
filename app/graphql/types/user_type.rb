Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, !types.ID
  field :quota, !types.Int
  field :name, !types.String
  field :image, !types.String
  field :number_of_wins, !types.Int
  field :number_of_losses, !types.Int
end
