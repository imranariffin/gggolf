class TournamentsController < ApplicationController
#simple handling methods for testing purpose. 
  def index
    @tournaments = Tournament.all
  end
  def new
    @tournament = Tournament.new()
  end
  def show
    @tournament = Tournament.find(params[:id])
    @players = @tournament.players()

    # get all users playing in this tournament
    @users = @players.map do |p|
      p.user
    end

    # available spot progress bar
    player_limit = @tournament.player_limit.to_f
    player_joined = @players.length.to_f
    @available_spot = ((player_limit - player_joined)/player_limit * 100).to_i
    # @available_spot = 10
  end	
  def edit
    @tournament = Tournament.find(params[:id])
  end
  def create
    @tournament = Tournament.new(tnm_params)
    @tournament.save
    redirect_to @tournament
  end
  def update
    @tournament = Tournament.find(params[:id])  
    @tournament.update(tnm_params)
    redirect_to @tournament
  end 
  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
 
    redirect_to tournaments_path
  end

  # current user joins a tournament as player
  def join
    @user = current_user
    @tournament = Tournament.find(params[:id])

    # update tournament
    @user_team = @tournament.teams.new()
    if @user_team.save()
      @user_player = @user.players.new(team_id: @user_team[:id])
      if @user_player.save()
        redirect_to tournament_path
      end
    end
  end

  private
    def tnm_params
      params.require(:tournament).permit(:title, :location, :start, :end, :description)
    end
end
