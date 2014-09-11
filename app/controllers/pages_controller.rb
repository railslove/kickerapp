class PagesController < ApplicationController
  layout 'landingpage', except: :pebble_settings
  def landing

  end

  def pebble_settings
    @leagues = League.all.sort_by(&:number_of_games).reverse
  end

  def imprint
    render 'pages/static'
  end

end
