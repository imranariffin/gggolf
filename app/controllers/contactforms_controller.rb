class ContactformsController < ApplicationController

 def new
    @contactform = Contactform.new
 end

  def create
    @contactform = Contactform.new(contactform_params)
    
    if @contactform.valid?
      ContactformMailer.new_message(@contactform).deliver
      redirect_to contact_path, notice: "Your messages has been sent."
    else
      flash[:alert] = "An error occurred while delivering this message."
      render :new
    end
  end

private

  def contactform_params
    params.require(:contactform).permit(:name, :email, :content)
  end



end
