# frozen_string_literal: true

json.array! @users do |user|
  json.call(user, :id, :name, :quota, :image)
  json.active user.active?
end
