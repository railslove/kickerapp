# == Schema Information
#
# Table name: tournaments
#
#  id               :integer          not null, primary key
#  number_of_tables :integer
#  location         :string
#  name             :string
#

class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all.order(created_at: :desc)
  end

  def create
    @tournament = Tournament.new tournament_params
    if @tournament.save!
      redirect_to tournaments_path
    else 
      redirect_to tournaments_path
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    @user = User.new
    @tournament_users = User.all.order(created_at: :desc)
  end

  def new
    @tournament = Tournament.new
  end

  def add_tournament_user
  end

  private
  def tournament_params
    params.require(:tournament).permit(:number_of_tables, :location, :name, :id)
  end
  
end