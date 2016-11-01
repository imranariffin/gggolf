class TournamentsController < ApplicationController
  protect_from_forgery with: :exception
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
    @ticket_options = @tournament.ticket_options
    puts @ticket_options.length
    @reg_sponsors = @tournament.reg_sponsors
    @sponsor_options = @tournament.sponsor_options
  end
  def create
    @tournament = Tournament.new
    @tournament.update(tnm_params)
    @tournament.save
    redirect_to url_for(action: 'edit', :id => @tournament.id)
  end
  def update
    @tournament = Tournament.find(params[:id])  
    @tournament.update(tnm_params)

    ticket_options = params[:ticket_options]
    reg_sponsors = params[:reg_sponsors]
    sponsor_options = params[:sponsor_options]

    @tournament.ticket_options.destroy_all
    @tournament.reg_sponsors.destroy_all
    @tournament.sponsor_options.destroy_all

    for i in 0..(if ticket_options.nil? then 0 else ticket_options[:ttype].length - 1 end)
      @tournament.ticket_options.create(:ttype => ticket_options[:ttype][i], :price => ticket_options[:price][i])
    end
    for i in 0..(if reg_sponsors.nil? then 0 else reg_sponsors[:ttype].length - 1 end)
      @tournament.reg_sponsors.create(:ttype => reg_sponsors[:ttype][i], 
        :name => reg_sponsors[:name][i], :website => reg_sponsors[:website][i])
    end
    for i in 0..(if sponsor_options.nil? then 0 else sponsor_options[:ttype].length - 1 end)
      @tournament.sponsor_options.create(:ttype => sponsor_options[:ttype][i], :price => sponsor_options[:price][i])
    end
    @tournament.save()

    redirect_to @tournament
  end
  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
 
    redirect_to tournaments_path
  end
  private
    def tnm_params
      params.permit(:title, :is_private, :golf_format, :schedule, :email, :phone,
        :features, :location, :start, :end, :description)
    end
end
