module ApplicationHelper

  def user_image(user)
    if user.image.present?
      image_tag(user.image, class: 'm-user-image')
    else
      content_tag :div, class: 'm-user-image as-default' do
        user.short_name
      end
      # gravatar_image_tag(user.email, class: 'm-user-image', :gravatar => { :default => asset_url('default_user.png'), size: 48 })
    end
  end

  def user_balance(user)
    percentage = user.win_percentage
    "#{percentage}% (#{user.number_of_games} games)"
  end

  def league?
    current_league.present?
  end

  def facebook_connect_path(league)
    "/auth/facebook"
  end

  def twitter_connect_path(league)
    "/auth/twitter"
  end

  def colored_difference(difference)
    content_tag(:span, difference, class: "m-score__#{difference > 0 ? 'positive' : 'negative'}")
  end

end
