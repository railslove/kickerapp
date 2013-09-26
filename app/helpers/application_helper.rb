module ApplicationHelper

  def user_image(user)
    image_tag(user.image.present? ? user.image : "default_user.png", class: 'm-user-image')
  end

  def user_balance(user)
    percentage = user.win_percentage
    "#{percentage}% (#{user.number_of_games})"
  end

end
