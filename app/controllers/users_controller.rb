# encoding: utf-8

class UsersController < ApplicationController

  before_filter :require_league

  def new
    @user = User.new
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      user = User.find_by_provider_and_uid_and_league_id(auth["provider"], auth["uid"], current_league.id) || User.create_with_omniauth(auth, current_league)
    else
      league = League.find_by!(slug: params[:league_id])
      user = User.create(user_params.merge({league_id: current_league.id}))
    end
    redirect_to new_league_match_url(current_league), notice: "Neuer Spieler #{user.name} in der Liga #{current_league.name} angelegt!"
  end

  def show
    @user = User.find(params[:id])
    @history_entries = @user.history_entries.order('date').last(100)
    @matches = @user.matches.first(20)
    @lowest_rank = current_league.history_entries.maximum(:rank)
    wins = @matches.select{|m| m.win_for?(@user)}
    looses = @matches - wins
    @trend = wins.sum(&:difference) - looses.sum(&:difference)

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def index

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to new_league_match_url(current_league), notice: "Spieler #{@user.name} in der Liga #{current_league.name} geändert!"
    else
      render :edit, alert: 'User konnte nicht gespeichert werden'
    end
  end

  def teams
    @teams = Team.for_doubles.ranked.sort_by(&:value).reverse
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :email)
  end

end
