class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    else
      user = User.create(user_params)
    end
    redirect_to new_match_url, :notice => "Neuer Spieler #{user.name} angelegt!"
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
    params.require(:user).permit(:name, :image)
  end

end
