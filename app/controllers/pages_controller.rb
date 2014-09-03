class PagesController < ApplicationController
  layout 'landingpage', only: :landing
  def landing

  end

  def pebble_settings
    @leagues = League.all.sort_by(&:number_of_games).reverse
  end

end
