class TournamentRegistrationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def new
  	@tournament = Tournament.find params[:tournament_id]
  	@teams = @tournament.teams
		@ticket_options = @tournament.ticket_options
  end

  def create
  	@player = current_user.players.new tournament_registration_params
  	@tournament = Tournament.find params[:tournament_id]

  	if !@tournament.has_player?(current_user.id) && @player.save
      Ticket.create(ticket_option_id: ticket_params[:ticket_option_id], player_id: @player.id)
  	  redirect_to tournament_path(@tournament)
  	else
  	  redirect_to new_tournament_tournament_registration_path(@tournament)
  	end
  end

  def destroy
  	@tournament = Tournament.find(params[:id])
		@player = @tournament.players.with_user_id(current_user.id).first
		@player.destroy if @player.present?
		redirect_to tournament_path(@tournament)

  end

  private

  def tournament_registration_params
  	params.permit(:team_id)
  end

  def ticket_params
    params.permit(:ticket_option_id)
  end
end 
