class MatchesController < ApplicationController
  def index
    if params[:user_id]
      @matches = User.find(params[:user_id]).matches.first(18)
    else
      @matches = Match.all.first(28)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matches }
    end
  end

  def new
    @match = Match.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @match }
    end
  end

  def edit
    @match = Match.find(params[:id])
  end

  def create
    team1 = Team.find_or_create_with_score(params[:team1][:users])
    team2 = Team.find_or_create_with_score(params[:team2][:users])
    User.update_ranking
    Match.create_from_params(params, team1, team2)
    respond_to do |format|
      format.html { redirect_to matches_path, notice: 'Match was successfully created.' }
      format.json { render json: @match, status: :created, location: @match }
    end
  end

  def update
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to matches_url }
      format.json { head :no_content }
    end
  end
end
