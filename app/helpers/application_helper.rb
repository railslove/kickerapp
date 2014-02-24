module ApplicationHelper

  def user_image(user)
    image_tag(user.image.present? ? user.image : "default_user.png", class: 'm-user-image')
  end

  def user_balance(user)
    percentage = user.win_percentage
    "#{percentage}% (#{user.number_of_games} games)"
  end

  def league?
    current_league.present?
  end

  def facebook_connect_path(league)
    "/auth/facebook?state=#{league.slug}"
  end

  def twitter_connect_path(league)
    "/auth/twitter?state=#{league.id}"
  end

end
