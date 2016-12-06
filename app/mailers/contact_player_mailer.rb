class ContactPlayerMailer < ApplicationMailer
    
    
  default from: "Your Mailer <gggolf444@gmail.com>"
  default to: "Your Name <your.email@yourdomain.com>"

  def new_message_player(message,user,current_user)
    @user = user
    @current_user = current_user
    @message = message
    
    mail( to:  user.email ,subject: "Hi, you have a message  from #{current_user.name}")
  end

end
