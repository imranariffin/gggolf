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
    # get all sponsors playing in this tournament
    @sponsors = @tournament.sponsors

    @enable_join = enable_join(current_user, @tournament)
    @enable_sponsor = enable_sponsor(current_user, @tournament)
    if current_user and not @enable_join
      @enable_unjoin = true
    else
      @enable_unjoin = false
    end

    # available spot progress bar
    if @tournament.player_limit
      player_limit = @tournament.player_limit.to_f
      player_joined = @players.length.to_f
      @available_spot = ((player_limit - player_joined)/player_limit * 100).to_i
    else
      @available_spot = 100.to_i
    end
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
    if not current_user
      # TODO: send error messages
      redirect_to tournament_path
      return
    end

    @user = current_user
    @tournament = Tournament.find(params[:id])

    if not enable_join(current_user, @tournament)
      # TODO: send error messages
      redirect_to tournament_path
      return
    end

    @user_team = @tournament.teams.new()
    if @user_team.save()
      @user_player = @user.players.new(team_id: @user_team[:id])
      if @user_player.save()
        redirect_to tournament_path
      end
    end
  end

  # current user quits (unjoins) the tournament
  # user must oredy joined the tournament
  def unjoin
    if current_user == nil
      raise RuntimeError
    end
    # remove from team
    # if team empty, also remove team from tournament
    # remove player from user
    @tournament = Tournament.find(params[:id])
    @user = current_user

    plyr_i = 0
    team_i = 0
    for player in @user.players
      for team in @tournament.teams
        if player[:team_id] == team[:id]
          @tournament.teams.delete(team[:id])
          @user.players.delete(player[:id])
          @tournament.save()
          @user.save()
          
          redirect_to @tournament
          return
        end
        team_i += 1
      end
      plyr_i += 1
    end

    # should never go here
    raise RuntimeError
  end

  # current user sponsors the tournament
  def sponsor
    if not current_user
      # TODO: send error message
      redirect_to tournament_path
      return
    end

    @user = current_user
    @tournament = Tournament.find(params[:id])

    if not enable_sponsor(current_user, @tournament)
      # TODO: send error messages
      redirect_to tournament_path
      return
    end

    @sponsor = @tournament.sponsors.new(:user => @user)
    if not @sponsor.save()
      # TODO: send error messages
      puts @sponsor.errors.messages
      return
    end
    redirect_to tournament_path
  end

  private
  def tnm_params
    params.require(:tournament).permit(:title, :location, :start, :end, :description)
  end

  # enable user join as player if they are 
  #   1 logged in
  #   2 haven't joined the tournament yet
  # prevent from joining twice
  def enable_join(current_user, tournament)
    if current_user
      for player in current_user.players
        for team in tournament.teams
          if player[:team_id] == team[:id]
            return false
          end
        end
      end
      return true
    end
    return false
  end

  # enable user sponsor the tournament if they are 
  #   1 logged in
  #   2 haven't sponsored the tournament yet
  # prevent from joining twice
  def enable_sponsor(current_user, tournament)
    if current_user
      tournament_sponsors = tournament.sponsors.map do |s|
        s.user[:id]
      end
      if tournament_sponsors.include? current_user[:id]
        return false
      end
      return true
    end
    return false
  end
end
