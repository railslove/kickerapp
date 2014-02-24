class UsersController < ApplicationController

  before_filter :require_league

  def new
    @user = User.new
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth, current_league)
    else
      league = League.find_by!(slug: params[:league_id])
      user = User.create(user_params.merge({league_id: current_league.id}))
    end
    redirect_to new_league_match_url(current_league), :notice => "Neuer Spieler #{user.name} in der Liga #{current_league.name} angelegt!"
  end

  def show
    @user = User.find(params[:id])
    @matches = @user.matches
  end

  def index

  end

  def teams
    @teams = Team.for_doubles.ranked.sort_by(&:value).reverse
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :email)
  end

end
