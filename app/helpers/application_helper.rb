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

  def current_ranking(user, index)
    if user.ranking == index || user.ranking.nil?
      'icon-minus'
    elsif user.ranking > index
      'icon-arrow-up'
    elsif user.ranking < index
      'icon-arrow-down'
    end
  end

  def ranking_title(user, index)
    if user.ranking == index || user.ranking.nil?
      "Position gehalten"
    elsif user.ranking > index
      "Aufgestiegen\n von Platz #{user.ranking+1} auf Platz #{index+1}"
    elsif user.ranking < index
      "Abgestiegen\n von Platz #{user.ranking+1} auf Platz #{index+1}"
    end
  end
end
