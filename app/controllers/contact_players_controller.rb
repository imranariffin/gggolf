class ContactPlayersController < ApplicationController
    
  def new
    @contact_player = ContactPlayer.new
    @user = User.find params[:id]
  end

  def create
    @contact_player = ContactPlayer.new(message_params)
    
    if @contact_player.valid?
      MessageMailer.new_message(@contact_player).deliver
      redirect_to contact_path, notice: "Your messages has been sent."
    else
      flash[:alert] = "An error occurred while delivering this message."
      render :new
    end
  end

private

  def message_params
    params.require(:contact_player).permit( :content)
  end

  def user_params
    params.require(:user).permit(:id, :name,:email)
  end 
    
end
