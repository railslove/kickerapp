# frozen_string_literal: true

class ApplicationController < ActionController::Base
  FLASH_TYPES = %i[success notice alert].freeze

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_league, :set_current_league

  before_action :set_locale

  def require_league
    unless current_league
      redirect_to root_path, alert: 'Bitte wähle zuerst eine Liga'
    end
  end

  def clear_current_league
    session.delete(:league_slug)
  end

  def current_league
    slug = params[:league_id] || session[:league_slug]
    set_current_league(slug)
    @current_league ||= (slug ? League.find_by!(slug: slug) : nil)
  end

  def set_current_league(league_slug)
    session[:league_slug] = league_slug
  end

  private

  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
