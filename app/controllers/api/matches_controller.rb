class Api::MatchesController < ApiController
  def index
    @matches = Match.all
    render json: @matches
  end

  def create
    team1 = [params['scores'].keys.first.to_i, Team.find_or_create_with_score(params['scores'][params['scores'].keys.first])]
    team2 = [params['scores'].keys.last.to_i, Team.find_or_create_with_score(params['scores'][params['scores'].keys.last])]
    match = Match.create_from_api(team1, team2, params['crawling'])
    render json: match
  end
end
