class TournamentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def show
    @tournament = Tournament.find params[:id]
    @players = @tournament.players
    @users = @players.map &:user
    @sponsors = @tournament.sponsors
    @enable_sponsor = enable_sponsor(current_user, @tournament)
    @available_spot = @tournament.player_availability.to_i
  end

  def edit
    @tournament = Tournament.find params[:id]
    @ticket_options = @tournament.ticket_options
    @reg_sponsors = @tournament.reg_sponsors
    @sponsor_options = @tournament.sponsor_options
  end

  def create
    @tournament = Tournament.create(tournament_params)
    if @tournament.save
      redirect_to edit_tournament_path(@tournament)
    else
      render 'new'
    end
  end

  def update
    @tournament = Tournament.find(params[:id])  
    @tournament.update(tournament_params)

    ticket_options = params[:ticket_options]
    reg_sponsors = params[:reg_sponsors]
    sponsor_options = params[:sponsor_options]

    @tournament.ticket_options.destroy_all
    @tournament.reg_sponsors.destroy_all
    @tournament.sponsor_options.destroy_all

    for i in 0..(if ticket_options.nil? then -1 else ticket_options[:ttype].length - 1 end)
      @tournament.ticket_options.create(:ttype => ticket_options[:ttype][i], :price => ticket_options[:price][i])
    end
    for i in 0..(if reg_sponsors.nil? then -1 else reg_sponsors[:ttype].length - 1 end)
      @tournament.reg_sponsors.create(:ttype => reg_sponsors[:ttype][i], 
        :name => reg_sponsors[:name][i], :website => reg_sponsors[:website][i])
    end
    for i in 0..(if sponsor_options.nil? then -1 else sponsor_options[:ttype].length - 1 end)
      @tournament.sponsor_options.create(:ttype => sponsor_options[:ttype][i], :price => sponsor_options[:price][i])
    end
    @tournament.save

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

    @user_team = @tournament.teams.new
    if @user_team.save
      @user_player = @user.players.new(team_id: @user_team[:id])
      if @user_player.save
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
          @tournament.save
          @user.save
          
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
    if not @sponsor.save
      # TODO: send error messages
      puts @sponsor.errors.messages
      return
    end
    redirect_to tournament_path
  end

  private


  def tournament_params
    params.require(:tournament).permit(:title, :is_private, :golf_format, :schedule, :email, :phone, :features, :location, :start_datetime, :end_datetime, :description, :player_limit, :user_id)
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
    false
  end
end
