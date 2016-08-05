class SettingsController < ApplicationController

  layout 'settings'

  def pebble
    if params[:config].present?
      @pebble_config = JSON.load params[:config]
      @current_league_slug = @pebble_config["league_slug"]
      @receive_notifications = @pebble_config["receive_notifications"] == '1'
    end
    @leagues = League.by_matches
  end

  def freckle
    if params[:config].present?
      @pebble_config = JSON.load params[:config]
      @token = @pebble_config["token"]
    end
  end

end
