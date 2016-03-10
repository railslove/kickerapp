class TournamentUsersController < ApplicationController

  def index
  end

  def create
    # User.destroy_all
    user = User.new tournament_user_params
    user.tournament_id = @tournament_id
    if user.save!
      redirect_to tournament_path(@tournament_id)
    else
      redirect_to tournament_path
    end
  end

  def destroy
    user = User.find params[:id]
    tournament = Tournament.find user.tournament_id
    if user.destroy!
      redirect_to tournament_path(params[:tournament_id])
    else
      render plain: "something went wrong"
    end
  end

  private
  def tournament_user_params
    @tournament_id = params[:tournament_id]
    params.require(:user).permit(:name, :id)
  end
end