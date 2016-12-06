class CheckInController < ApplicationController
  def new
  	@tournament = Tournament.find(params[:tournament_id])
  end

  def create
  	@ticket = Ticket.find(params[:ticket_id])
  	if @ticket.update(checked_in: true)
  	  flash[:success] = 'Player has been successfully checked in'
      redirect_to tournament_path(params[:tournament_id])
  	else
  	  redirect_to new_tournament_check_in_path(@tournament)
  	end
  end
end
