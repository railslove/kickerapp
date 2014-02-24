class TeamsController < ApplicationController
  before_filter :require_league
  def index
    @teams = current_league.teams.for_doubles.ranked.sort_by(&:value).reverse
  end

end
