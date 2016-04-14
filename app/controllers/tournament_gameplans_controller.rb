class TournamentGameplansController < ApplicationController

  def create
    @tournament = Tournament.find(params[:tournament_id])
    if @tournament.users.count % 2 == 0
      @tournament.create_gameplan
      redirect_to tournament_tournament_gameplan_path(@tournament)
    else
      render text: "Es muss eine gerade Anzahl an Spielern vorhanden sein, there are #{@tournament.users.count} players at the moment"
    end
  end

  def show
    @tournament = Tournament.find(params[:tournament_id])
    @matches = @tournament.new_matches.order(:tournament_position)
    @hide_sidebar = true
  end


  def update
    #add changes e.g. new results 
  end
  
end
