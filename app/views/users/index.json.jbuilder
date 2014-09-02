json.array! @users do |user|
  json.(user, :name, :quote, :image)
  json.active user.active?
end
