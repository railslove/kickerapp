class PagesController < ApplicationController

  layout 'landingpage', except: [:pebble_settings, :kpis]
  http_basic_authenticate_with name: "kicker", password: "loveisallaround", only: :kpis unless Rails.env.development?

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

  def kpis
    start_date = Date.parse('08.09.2014')
    @active_leagues = League.where.not(name: 'Railslove').select{|l|(l.matches.count > 10) && (l.matches.first.date > 14.days.ago)}

    @user_per_week = User.reorder(:created_at).where('created_at > ?',start_date).group_by{|u| u.created_at.to_date.cweek}.map{|w|[w.first, w.last.count]}
    matches = Match.reorder(:date).where('date > ?',start_date).where(league_id: @active_leagues.map(&:id))
    @matches_per_week = matches.group_by{|m| m.date.to_date.cweek}.map{|w|[w.first, w.last.count]}
  end

end
