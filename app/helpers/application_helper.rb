module ApplicationHelper
  def team_pictures(team)
    team.users.map do |user|
      image_tag(user.image, :title => user.name)
    end.join(" ").html_safe
  end

  def percentage number_between_0_and_1
    "#{(number_between_0_and_1 * 100).round}%"
  end

  def match_balance(wins, loses)
    "(#{wins} - #{loses})"
  end
end
