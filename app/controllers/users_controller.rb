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

      tracker do |t|
        t.google_analytics :send, { type: 'event', category: 'user', action: 'create', label: current_league.name, value: user.name}
      end

      redirect_to new_league_match_url(current_league), notice: t('.success', user_name: user.name, league_name: current_league.name)
    else
      @user = User.new(user_params.merge({league: current_league}))
      if @user.save
        redirect_to new_league_match_url(current_league), notice: t('.success', user_name: @user.name, league_name: current_league.name)
      else
        flash.now[:alert] = t('users.create.failure')
        render :new
      end
    end
  end

  def omniauth_failure
    redirect_to new_league_user_path(current_league), alert: t('users.create.omniauth_failure', message: params[:message], strategy: params[:strategy])
  end

  def show
    @user = current_league.users.find_by(id: params[:id])
    redirect_to current_league and return unless @user
    @history_entries = @user.history_entries.order('date').last(100)
    @matches = @user.matches.first(20)
    @lowest_rank = current_league.history_entries.maximum(:rank)
    wins = @matches.select{|m| m.win_for?(@user)}
    losses = @matches - wins
    @trend = wins.sum(&:difference) - losses.sum(&:difference)
  end

  def index
    @users = current_league.users.ranked
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
