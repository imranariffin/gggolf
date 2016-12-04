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
  	  redirect_to tournament_path(@tournament)
  	else
  	  redirect_to new_tournament_tournament_registration_path(@tournament)
  	end
  end

  def destroy
  	@tournament = Tournament.find(params[:id])
<<<<<<< HEAD
  	@player = @tournament.players.with_user_id(current_user.id).first

  	@player.destroy if @player.present?
  	redirect_to tournament_path(@tournament)
=======
		@player = @tournament.players.with_user_id(current_user.id).first

		@player.destroy if @player.present?
		redirect_to tournament_path(@tournament)
>>>>>>> master
  end

  private

  def tournament_registration_params
  	params.permit(:team_id)
  end
end 
