# encoding: utf-8

class MatchesController < ApplicationController
  before_filter :require_league
  has_mobile_fu false

  def index
    redirect_to league_path(current_league)
  end

  def new
    @match = Match.new
    @team1 = Team.find_or_create(params[:team1].values) if params[:team1]
    @team2 = Team.find_or_create(params[:team2].values) if params[:team2]
  end

  def create
    param = {}
    crawl_match_id = create_matches_from_params(params)
    param[:crawl_id] = crawl_match_id if crawl_match_id
    if is_mobile_device?
      redirect_to new_league_match_path(current_league, team1: params["team1"], team2: params["team2"], created: true)
    else
      redirect_to league_path(current_league, param), notice: t('.success')
    end
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    @match.revert_points
    if params[:winner_score].to_i < params[:loser_score].to_i
      @match.score = @match.score_for_set(params[:loser_score], params[:winner_score])
      @match.swap_teams
    else
      @match.score = @match.score_for_set(params[:winner_score], params[:loser_score])
    end
    @match.crawling = params[:crawling]
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
    user_ids = params[:user_ids].select{|id| id.present?}
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

  def create_matches_from_params(params)
    league = League.find_by!(slug: params[:league_id])
    crawl_id = nil
    ActiveRecord::Base.transaction do
      3.times do |i| #Three possible sets
        set = params["set#{i+1}"]
        if set.first.present? && set.last.present? # If the set has been played
          match = Match.create_from_set({
            score: set,
            crawling: params["crawling#{i+1}"].present?,
            team1: params[:team1],
            team2: params[:team2],
            league_id: league.id.to_s
          })
          HistoryEntry.track(match)
          crawl_id = match.id if params["crawling#{i+1}"].present?
        end
      end
      league.update_badges
    end
    crawl_id
  end

  def force_mobile_html
    session[:mobile_view] = true
  end
end
