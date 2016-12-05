class ContactPlayerMailer < ApplicationMailer
    
    
  default from: "Your Mailer <noreply@yourdomain.com>"
  default to: "Your Name <your.email@yourdomain.com>"

  def new_message(message)
    @contact_player = message
    
    mail subject: "Message from #{message.name}"
  end

end
