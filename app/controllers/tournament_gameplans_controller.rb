class TournamentGameplansController < ApplicationController

  def create
    @tournament = Tournament.find(params[:tournament_id])
    if @tournament.users.count % 2 == 1
      @tournament.create_gameplan
      redirect_to tournament_tournament_gameplan_path(@tournament)
    else
      render text: "Es muss eine gerade Anzahl an Spielern vorhanden sein, there are #{@tournament.users.count} players at the moment"
    end
  end

  def show
    @tournament = Tournament.find(params[:tournament_id])
    @hide_sidebar = true
  end
end
