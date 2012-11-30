module ApplicationHelper
  def team_pictures(team)
    team.users.map do |user|
      image_tag(user.image)
    end.join(" ").html_safe
  end

  def match_balance(user)
    "#{user.wins.count} - #{user.loses.count}"
  end
end
