json.array! @users do |user|
  json.(user, :id, :name, :quota, :image)
  json.active user.active?
end
