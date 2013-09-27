# encoding: utf-8

class MatchesController < ApplicationController
  def index
    @matches = Match.all
    respond_to do |format|
      format.html # index.html.erb
      format.atom
      format.json { render json: @matches }
    end
  end

  def new
    @match = Match.new
  end

  def create
    create_matches_from_params(params)
    redirect_to matches_path, notice: "Spiele wurden eingetragen."
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if params[:winner_score].to_i < params[:looser_score].to_i
      @match.score = @match.score_for_set(params[:looser_score], params[:winner_score])
      @match.revert_points
      @match.swap_teams
      @match.calculate_user_quotes
    else
      @match.score = @match.score_for_set(params[:winner_score], params[:looser_score])
    end
    if @match.save
      redirect_to matches_path, notice: "Satz gespeichert."
    else
      flash.now[:alert] = "Satz konnte nicht gespeichert werden."
      render :edit
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.revert_points
    @match.destroy
    redirect_to matches_path, notice: "Dieser Satz wurde gelöscht."
  end

  def shuffle
    @match = Match.new
    if params[:user_ids].select{|id| id.present?}.size == 4
      @teams = Team.shuffle(params[:user_ids])
      flash.now[:notice] = "Es spielen #{@teams.first.name} gegen #{@teams.last.name}"
      render :new
    else
      redirect_to shuffle_select_matches_path, alert: "Bitte wähle 4 Spieler aus!"
    end
  end

  def shuffle_select

  end

  private

  def create_matches_from_params(params)
    3.times do |i| #Three possible sets
      set = params["set#{i+1}"]
      if set.first.present? && set.last.present? # If the set has been played
        result_params = { crawling: params["crawling#{i+1}"].present? }
        params["team1"].each_with_index do |user_id, index|
          result_params[user_id] = set.first.to_i
          result_params[params["team2"][index]] = set.last.to_i
        end
        Match.create_from_set(result_params)
      end
    end
  end
end
