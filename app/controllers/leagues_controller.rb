class LeaguesController < ApplicationController

  def index
    clear_current_league
    @leagues = League.by_matches
  end

  def new
    clear_current_league
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    if @league.save
      set_current_league(@league.slug)
      AdminMailer.new_league(@league.id).deliver
      redirect_to new_league_user_path(@league), notice: t('leagues.create.success')
    else
      flash.now[:alert] = t('leagues.create.failure')
      render :new
    end
  end

  def show
    @league = League.find_by!(slug: params[:id])
    set_current_league(@league.slug)
    @matches = @league.matches.including_teams.limit(30)
    @crawling_match = Match.find(params[:crawl_id]) if params[:crawl_id]
    respond_to do |format|
      format.html # index.html.erb
      format.atom
      format.json
    end
  end

  def badges
    @league = League.find_by!(slug: params[:id])
    set_current_league(@league.slug)
    @order = params[:order] || 'longest_winning_streak_games'
    @users = @league.users.order("#{@order} desc").select{|user| user.active? }
  end

  def table
    @league = League.find_by!(slug: params[:id])
    set_current_league(@league.slug)
    render layout: 'pure'
  end

  private

    def league_params
      params.require(:league).permit(:name, :slug, :contact_email)
    end

end
