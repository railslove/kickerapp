# == Schema Information
#
# Table name: teams
#
#  id               :integer          not null, primary key
#  player1_id       :integer
#  player2_id       :integer
#  number_of_wins   :integer          default(0)
#  number_of_losses :integer          default(0)
#  created_at       :datetime
#  updated_at       :datetime
#  league_id        :integer
#  tournament_id    :integer
#

class TeamsController < ApplicationController
  before_filter :require_league

  def index
    @teams = current_league.team_ranking
  end

  def show
    @team = current_league.teams.find(params[:id])
    @matches = @team.matches.page(params[:page]).per(params[:per_page] || 25)
  end

end
