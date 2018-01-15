# encoding: utf-8

class MatchesController < ApplicationController
  before_action :require_league
  has_mobile_fu false

  def index
    @date = match_params['date'] && Date.parse(match_params['date']) || Date.today
    @matches = current_league.matches.by_date(@date)
  end

  def new
    @match = Match.new
    @team1 = Team.find_or_create(match_params[:team1].values.reject(&:blank?)) if match_params[:team1]
    @team2 = Team.find_or_create(match_params[:team2].values.reject(&:blank?)) if match_params[:team2]
    @sets = []
    3.times do |i|
      @sets[i] = match_params["set#{i+1}"] if match_params["set#{i+1}"].present?
    end
    @crawlings = []
    3.times do |i|
      @crawlings[i] = match_params["crawling#{i+1}"] if match_params["crawling#{i+1}"].present?
    end
  end

  def create
    param = {}
    matches = create_matches_from_params
    if !matches.map(&:errors).map(&:empty?).reduce(:&)
      redirect_to new_league_match_path(current_league, match_params), alert: "#{t('matches.create.failure')} #{matches.map(&:errors).inspect}"
    else
      matches.first.update_team_streaks
      tracker do |t|
        t.google_analytics :send, { type: 'event', category: 'match', action: 'create', label: current_league.name, value: matches.map(&:crawling).any?}
      end
      if is_mobile_device?
        redirect_to new_league_match_path(current_league, team1: match_params["team1"], team2: match_params["team2"], created: true)
      else
        param[:crawl_id] = matches.select(&:crawling).last.id if matches.map(&:crawling).any?
        redirect_to league_path(current_league, param), notice: t('.success')
      end
    end
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    @match.revert_points
    if match_params[:winner_score].to_i < match_params[:loser_score].to_i
      @match.score = @match.score_for_set(match_params[:loser_score], match_params[:winner_score])
      @match.swap_teams
    else
      @match.score = @match.score_for_set(match_params[:winner_score], match_params[:loser_score])
    end
    @match.crawling = match_params[:crawling]
    @match.calculate_user_quotas
    current_league.update_badges
    if @match.save
      @match.update_team_streaks
      redirect_to league_path(current_league), notice: "Satz gespeichert."
    else
      flash.now[:alert] = "Satz konnte nicht gespeichert werden."
      render :edit
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.revert_points
    @match.destroy
    redirect_to league_path(current_league), notice: "Dieser Satz wurde gelöscht."
  end

  def shuffle
    @match = Match.new
    user_ids = match_params[:user_ids].select{|id| id.present?}
    if user_ids.size >= 4
      user_ids = user_ids.sample(4) if user_ids.size > 4 #Choose 4 players from array
      teams = Team.shuffle(user_ids)
      @team1 = teams.first
      @team2 = teams.last
      flash.now[:notice] = "Es spielen #{@team1.name} gegen #{@team2.name}"
      render :new
    else
      redirect_to shuffle_select_league_matches_path(current_league), alert: "Bitte wähle 4 Spieler aus!"
    end
  end

  def show
    redirect_to league_path(current_league)
  end

  def shuffle_select

  end

  private

  def create_matches_from_params
    league = League.find_by!(slug: params[:league_id])
    matches = []
    ApplicationRecord.transaction do
      3.times do |i| #Three possible sets
        set = params["set#{i+1}"]
        if set.first.present? && set.last.present? # If the set has been played
          match = Match.create_from_set({
            score: set,
            crawling: match_params["crawling#{i+1}"].present?,
            team1: match_params[:team1],
            team2: match_params[:team2],
            league_id: league.id.to_s
          })
          matches << match
          HistoryEntry.track(match) if match.persisted?
        end
      end
      league.update_badges
    end
    matches
  end

  def force_mobile_html
    session[:mobile_view] = true
  end

  def match_params
    params.permit!
  end
end
