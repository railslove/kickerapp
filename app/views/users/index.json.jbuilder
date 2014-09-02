json.array! @users do |user|
  json.(user, :id, :name, :quote, :image)
  json.active user.active?
end
