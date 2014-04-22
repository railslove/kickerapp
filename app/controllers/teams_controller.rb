class TeamsController < ApplicationController
  before_filter :require_league

  def index
    @teams = current_league.teams.for_doubles.ranked.sort_by(&:value).reverse
  end

  def show
    @team = current_league.teams.find(params[:id])
    @matches = @team.matches.page(params[:page]).per(params[:per_page] || 25)
  end

end
