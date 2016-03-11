class TournamentGameplansController < ApplicationController

  def create
    @tournament = Tournament.find(params[:tournament_id])
    @tournament.create_gameplan
    redirect_to tournament_tournament_gameplan_path(@tournament)
  end

  def show
    @tournament = Tournament.find(params[:tournament_id])
  end
end
