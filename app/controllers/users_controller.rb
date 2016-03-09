# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  number_of_wins               :integer          default(0)
#  number_of_losses             :integer          default(0)
#  quota                        :integer          default(1200)
#  name                         :string
#  created_at                   :datetime
#  updated_at                   :datetime
#  provider                     :string
#  uid                          :string
#  image                        :string
#  league_id                    :integer
#  email                        :string
#  winning_streak               :integer          default(0)
#  number_of_crawls             :integer          default(0)
#  number_of_crawlings          :integer          default(0)
#  top_crawler                  :boolean          default(FALSE)
#  worst_crawler                :boolean          default(FALSE)
#  most_wins                    :boolean          default(FALSE)
#  longest_winning_streak       :boolean          default(FALSE)
#  most_teams                   :boolean          default(FALSE)
#  longest_winning_streak_games :integer          default(0)
#  longest_winning_streak_ever  :boolean          default(FALSE)
#


class UsersController < ApplicationController

  before_filter :require_league

  def new
    @user = User.new
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      user = User.find_by_provider_and_uid_and_league_id(auth["provider"], auth["uid"], current_league.id) || User.create_with_omniauth(auth, current_league)
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
    @user = User.find(params[:id])
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
