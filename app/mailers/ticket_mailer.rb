class TicketMailer < ApplicationMailer
  default from: "Golfly <gggolf444@gmail.com>"
  default to: "Your Name <gggolf444@gmail.com>"

  def send_ticket(ticket)
    @ticket = ticket
    mail(to: ticket.email, subject: 'Here is your ticket to a golf tournament')
  end 
end
