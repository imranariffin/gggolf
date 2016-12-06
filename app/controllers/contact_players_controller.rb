class ContactPlayersController < ApplicationController
    
  def new
    @user = User.find params[:user_id]
    @contact_player = ContactPlayer.new
    @current_user= current_user
    
  end

  def create
    @contact_player = ContactPlayer.new(message_params)
    
    if @contact_player.valid?
      MessageMailer.new_message_player(@contact_player).deliver
      redirect_to new_user_contact_player_path, notice: "Your messages has been sent."
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
