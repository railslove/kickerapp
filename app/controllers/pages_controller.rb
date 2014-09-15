class PagesController < ApplicationController
  layout 'landingpage', except: :pebble_settings
  def landing

  end

  def pebble_settings
    @leagues = League.by_matches
  end

  def imprint
    render 'pages/static'
  end

  def faq
    render 'pages/static'
  end

end
