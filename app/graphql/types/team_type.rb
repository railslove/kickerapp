# frozen_string_literal: true

Types::TeamType = GraphQL::ObjectType.define do
  name 'Team'
  field :id, !types.ID
  field :player1, Types::UserType
  field :player2, Types::UserType
  field :number_of_wins, types.Int
  field :number_of_losses, types.Int
  field :name, types.String
  field :percentage, types.Int
  field :score, types.Int do
    resolve ->(obj, _args, _ctx) {
      obj.value
    }
  end
end
