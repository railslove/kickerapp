class LeaguesController < ApplicationController

  before_filter :require_league, only: [:badges]

  def index
    clear_current_league
    @leagues = League.all.sort_by(&:number_of_games).reverse
  end

  def new
    clear_current_league
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    if @league.save
      set_current_league
      AdminMailer.new_league(@league.id).deliver
      redirect_to league_path(@league), notice: t('leagues.create.success')
    else
      flash.now[:alert] = t('leagues.create.failure')
      render :new
    end
  end

  def show
    @league = League.find_by!(slug: params[:id])
    set_current_league
    @matches = @league.matches.limit(30)
    respond_to do |format|
      format.html # index.html.erb
      format.atom
      format.json
    end
  end

  def badges
    @league = League.find_by!(slug: params[:id])
    @order = params[:order] || 'longest_winning_streak_games'
    @users = @league.users.order("#{@order} desc").select{|user| user.active? }
  end

  private

  def league_params
    params.require(:league).permit(:name, :slug)
  end
end
