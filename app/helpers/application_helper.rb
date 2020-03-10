module ApplicationHelper

  def user_image(user, _size='80x80')
    if user.image.present?
      image_tag(user.image, class: 'm-user-image')
    else
      color = Digest::MD5.hexdigest(user.name).first(6)
      content_tag :div, class: 'm-user-image as-default ', 'data-fill'=>  "##{color}" do
        image=content_tag :div, class: 'm-user-image--default-image' do
          raw(svg_tag('default_user.svg').gsub('fill="#E6B212"', "fill=##{color}"))
        end
        name=content_tag :div, class: 'm-user-image--default-name' do
          user.short_name
        end
        concat(image)
        concat(name)
      end
    end
  end

  def user_balance(user)
    percentage = user.win_percentage
    "#{percentage}% (#{user.number_of_games} games)"
  end

  def league_present?
    current_league.present?
  end

  def facebook_connect_path(league)
    "/auth/facebook"
  end

  def twitter_connect_path(league)
    "/auth/twitter"
  end

  def positive_negative(difference)
    "as-#{difference > 0 ? 'positive' : 'negative'}"
  end

  def signed(number)
    sprintf("%+d", number)
  end

  def match_css_classes(match, difference)
    css = [positive_negative(difference)]
    css << 'as-crawling' if match.crawling?
    css.join(' ')
  end

  def svg_tag(path)
    file = File.open("#{Rails.root}/app/assets/images/#{path}", "rb")
    raw(file.read)
  end

  def other_locale(locale)
    case locale
      when :de
        :en
      when :en
        :de
      else
        I18n.default_locale
      end
  end

  def picturefill_image_tag(regular, retina, options = {})
    srcset = "#{asset_path(regular)}, #{asset_path(retina)} 2x"
    image_tag(regular, options.merge(srcset: srcset))
  end

  def facebook_locale
    if I18n.locale == :de
      'de_de'
    else
      'en_gb'
    end
  end

  def pingpong?
    ENV['GAME_TYPE'] == 'pingpong'
  end

  def meta_title
    I18n.t("meta.#{ENV['GAME_TYPE']}.title")
  end

  def meta_description
    I18n.t("meta.#{ENV['GAME_TYPE']}.description")
  end

end
