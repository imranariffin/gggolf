class ContactPlayerMailer < ApplicationMailer
    
    
  default from: "Goftly <gggolf444@gmail.com>"
  default to: "golfer <gggolf444@gmail.com>"

  def new_message_player(message,user,current_user)
    @user = user
    @current_user = current_user
    @message = message
    
    mail( to:  user.email ,subject: "Hi, you have a message  from #{current_user.name}")
  end

end
