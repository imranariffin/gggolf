class TeamsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def new
  	@team = Team.new
  end

  def create
  	@team = Team.new(team_params)
  	if @team.save
      redirect_to new_tournament_tournament_registration_path
    else
      redirect_to new_tournament_team_path
  	end
  end

  private

  def team_params
  	params.require(:team).permit(:tournament_id, :name)
  end
end
