class TournamentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :sponsor]
  before_action :is_tournament_admin!, only: [:edit, :update, :destroy]

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
    @ticket_options = @tournament.ticket_options
    @sponsor_options = @tournament.sponsor_options
    @available_spot = @tournament.player_availability.to_i
    
    # show google map using tournament address
    gmap_root_url = "https://www.google.com/maps/embed/v1/place"
    gmapkey = "AIzaSyC-3qdPg9MxPjVXNNyzuDzJU7IpNLcOb1U"
    gmap_addr = @tournament.location.squish.tr(" ",",")
    @tournament_gmap_url = gmap_root_url + "?key=" + gmapkey + "&q=" + gmap_addr
  end

  def edit
    @tournament = Tournament.find params[:id]
    @ticket_options = @tournament.ticket_options
    @sponsor_options = @tournament.sponsor_options
  end

  def create
    @tournament = Tournament.create(tournament_params)
    if @tournament.save
      @tournament.admins.create user_id: current_user.id
      flash[:success] = 'Tournament has been successfully created'
      redirect_to tournament_path(@tournament)
    else
      render 'new'
    end
  end

  def update
    @tournament = Tournament.find(params[:id])  

    if @tournament.update_attributes tournament_params
      redirect_to @tournament, notice: 'Tournament was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @tournament = Tournament.find params[:id]
    @tournament.destroy
    redirect_to tournaments_path
  end

  # current user sponsors the tournament
  def sponsor
    user = current_user
    tournament = Tournament.find params[:id]
    #tournament.sponsors.create(user: user) if user && !tournament.has_sponsor?(user.id)
    redirect_to tournament_path(tournament)
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :is_private, :golf_format, :schedule, :email, :phone, :features,
                                       :location, :start_datetime, :end_datetime, :description, :player_limit, :user_id,
                                       ticket_options_attributes: [:id, :ttype, :price, :_destroy],
                                       sponsor_options_attributes: [:id, :ttype, :price, :_destroy] )
  end

  def is_tournament_admin!
    tournament = Tournament.find params['id'].to_i
    unless tournament.has_admin? current_user.id
      flash[:error] = 'Only tournament admins can edit or destroy a tournament.'
      redirect_to tournament
    end
  end
end
