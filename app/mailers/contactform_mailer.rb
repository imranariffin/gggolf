class ContactformMailer < ApplicationMailer
    
  default from: "Your Mailer <gggolf444@gmail.com>"
  default to: "Your Name <gggolf444@gmail.com>"

  def new_message(contactform)
    @contactform = contactform
    
    mail( to: 'gggolf444@gmail.com' ,subject: "Message from #{contactform.name}")

  end

    
end
