class ContactPlayerMailer < ApplicationMailer
    
    
  default from: "Your Mailer <gggolf444@gmail.com>"
  default to: "Your Name <your.email@yourdomain.com>"

  def new_message_player(user,current_user)
    @contact_player = user
    
    mail( to:  user.email ,subject: "Message from #{current_user.name}")
  end

end
