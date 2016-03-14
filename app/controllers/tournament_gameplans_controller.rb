class TournamentGameplansController < ApplicationController

  def index
  end

  def show
    # render plain: params
    @tournament_id = params[:tourid]
    # @tournament_users = User.all
    # @number_of_users = User.count
    # @number_of_teams = @number_of_users / 2
    # @number_of_matches = calc_numb_of_matches @number_of_teams
    # @number_of_sessions = calc_numb_of_sessions @number_of_matches
  end


  private 
  def calc_numb_of_sessions numb_of_games
    if numb != 0
      Math.log2(numb_of_games).to_i
    else
      0
    end
  end

  def calc_numb_of_matches number_of_teams
    if number_of_teams < 2
      out = 0
    elsif number_of_teams == 2
      out = 1 
    else
      out = power number_of_teams, 2
    end
  end

  def power limit, base
    base *= 2
    if base < limit
      base = power limit, base
    end
    base
  end



end