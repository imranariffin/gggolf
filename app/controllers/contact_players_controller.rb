class ContactPlayersController < ApplicationController
    
  def new
    @user = User.find params[:user_id]
    @contact_player = ContactPlayer.new
    @current_user= current_user
    
  end

  def create
    @contact_player = ContactPlayer.new(message_params)
    @user = User.find params[:user_id]
    @current_user= current_user
    if @contact_player.valid?
      ContactPlayerMailer.new_message_player(@contact_player ,@user,@current_user).deliver
      redirect_to @user, notice: "Your messages has been sent."
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
