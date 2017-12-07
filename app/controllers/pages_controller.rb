# frozen_string_literal: true

class PagesController < ApplicationController
  layout 'landingpage', except: %i[pebble_settings kpis]
  http_basic_authenticate_with name: 'kicker', password: (ENV['ADMIN_PASS'] || 'secret_password'), only: :kpis unless Rails.env.development?

  def landing
    @point_user = User.order(quota: :desc).first
    @game_user = User.order('number_of_wins + number_of_losses desc').first
    @longest_user = User.order(longest_winning_streak_games: :desc).first
  end

  def pebble_settings
    if params[:config].present?
      @pebble_config = JSON.load params[:config]
      @current_league_slug = @pebble_config['league_slug']
      @receive_notifications = @pebble_config['receive_notifications'] == '1'
    end
    @leagues = League.by_matches
  end

  def freckle_pebble_settings
    if params[:config].present?
      @pebble_config = JSON.load params[:config]
      @token = @pebble_config['token']
    end
  end

  def imprint
    render 'pages/static'
  end

  def faq
    render 'pages/static'
  end

  def kpis
    start_date = Date.parse('01.01.2017')
    @active_leagues = League.where.not(name: 'Railslove').select { |l| (l.matches.count > 10) && (l.matches.first.date > 14.days.ago) }

    @user_per_week = User.reorder(:created_at).where('created_at > ?', start_date).group_by { |u| u.created_at.to_date.cweek }.map { |w| [w.first, w.last.count] }
    matches = Match.reorder(:date).where('date > ?', start_date).where(league_id: @active_leagues.map(&:id))
    @matches_per_week = matches.group_by { |m| m.date.to_date.cweek }.map { |w| [w.first, w.last.count] }
  end
end
