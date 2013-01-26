# generate some fake users
4.times do |n|
  u = User.new
  u.name = "User #{n+1}"
  u.image = "/seed_data/user#{n+1}.png"
  u.save
end