json.array! @users do |user|
  json.(user, :name, :quote, :image)
end
