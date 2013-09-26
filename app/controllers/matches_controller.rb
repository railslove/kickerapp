class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def create
    create_matches_from_params(params)
    redirect_to matches_path, notice: "Spiele wurden eingetragen"
  end

  private

  def create_matches_from_params(params)
    3.times do |i| #Three possible sets
      set = params["set#{i+1}"]
      if set.first.present? && set.last.present? # If the set has been played
        result_params = { crawling: params["crawling#{i+1}"].present? }
        params["team1"].each_with_index do |user_id, index|
          result_params[user_id] = set.first.to_i
          result_params[params["team2"][index]] = set.last.to_i
        end
        Match.create_from_set(result_params)
      end
    end
  end
end
