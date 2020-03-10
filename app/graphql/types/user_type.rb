# frozen_string_literal: true

Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, !types.ID
  field :quota, !types.Int
  field :name, !types.String
  field :image, !types.String do
    resolve ->(obj, _args, _ctx) {
      obj.image.present? ? obj.image : 'https://kicker.cool/open-graph-logo.png'
    }
  end
  field :number_of_wins, !types.Int
  field :number_of_losses, !types.Int
  field :longest_winning_streak_games, types.Int
  field :winning_streak, types.Int
  field :number_of_crawls, types.Int
  field :number_of_crawlings, types.Int
  field :highest_quota, types.Int do
    resolve ->(obj, _args, _ctx) {
      obj.history_entries.order('quota desc').take.quota
    }
  end

  field :lowest_quota, types.Int do
    resolve ->(obj, _args, _ctx) {
      obj.history_entries.order('quota asc').take.quota
    }
  end

  field :best_partner, Types::UserType do
    resolve ->(obj, _args, _ctx) {
      team = obj.teams.for_doubles.ranked.sort_by(&:value).reverse.first
      team.partner_for(obj)
    }
  end

  field :worst_partner, Types::UserType do
    resolve ->(obj, _args, _ctx) {
      team = obj.teams.for_doubles.ranked.sort_by(&:value).first
      team.partner_for(obj)
    }
  end
end
