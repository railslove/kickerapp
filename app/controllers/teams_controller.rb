class TeamsController < ApplicationController
  before_filter :require_league

  def index
    @teams = current_league.team_ranking(params.fetch(:filter, {}))
  end

  def show
    @team = current_league.teams.find(params[:id])
    @matches = @team.matches.page(params[:page]).per(params[:per_page] || 25)
  end

end
