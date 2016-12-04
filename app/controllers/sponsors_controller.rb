class SponsorsController < ApplicationController
	before_action :authenticate_user!, only: [:new]

	def new
		# continue to registration
		@user = current_user
		@tournament = Tournament.find params[:tournament_id]
		@sponsor_options = @tournament.sponsor_options
	end

	def create
		@sponsor = Sponsor.new()
		@tournament = Tournament.find params[:tournament_id]
		@sponsor.user_id = current_user.id
      	@sponsor.tournament_id = @tournament.id
      	@sponsor.sponsor_opt_id = params[:sponsor_selected]

      	if @sponsor.save
  	  		redirect_to tournament_path(@tournament)
  		else
  			flash[:error] = "Oops, something broke!"
  	  		redirect_to tounament_sponsor_path(@tournament)
  		end
	end

end