class TournamentUsersController < ApplicationController

  def index
  end

  def create
    # User.destroy_all
    tournament = Tournament.find params[:tournament_id]
    user = tournament.users.new tournament_user_params
    if user.save!
      redirect_to tournament_path(tournament.id)
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
    params.require(:user).permit(:name, :id, :tournament_id)
  end
end