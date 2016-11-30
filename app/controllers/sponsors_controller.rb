class SponsorsController < ApplicationController
	before_action :authenticate_user!, only: [:new]

	def new
      # continue to registration
      @user = current_user
      @tournament = Tournament.find params[:tournament_id]
      @sponsor = Sponsor.new()
      @sponsor.user_id = @user.id
      @sponsor.tournament_id = @tournament.id

	end

end