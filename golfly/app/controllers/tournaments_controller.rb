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
  private
    def tnm_params
      params.require(:tournament).permit(:title, :location, :start, :end, :description)
    end
end
