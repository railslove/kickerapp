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
    @tournaments = Tournament.all
  end

  def create
    @tournament = Tournament.new tournament_params
    if @tournament.save!
      redirect_to tournaments_path
    else 
      render plain: "Ups, something went wrong :("
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    @tournament_users = @tournament.users.order(created_at: :desc)
    @user = User.new
  end

  def new
    @tournament = Tournament.new
  end

  private
  def tournament_params
    params.require(:tournament).permit(:number_of_tables, :location, :name, :id)
  end
  
end