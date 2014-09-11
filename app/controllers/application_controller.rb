# encoding: utf-8

class ApplicationController < ActionController::Base

  FLASH_TYPES = [:success, :notice, :alert]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_league

  def require_league
    if !current_league
      redirect_to root_path, alert: 'Bitte wähle zuerst eine Liga'
    end
  end

  def set_current_league
    session[:league] = @league.id if @league.present?
  end

  def clear_current_league
    session.delete(:league)
  end

  def current_league
    if session[:league]
      League.find(session[:league])
    else
      id = params[:league_id] || params[:id]
      id ? League.find_by!(slug: id) : nil
    end
  end

end
