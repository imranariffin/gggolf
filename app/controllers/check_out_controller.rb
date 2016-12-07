class CheckOutController < ApplicationController
  def registration
    @payment_amount = TicketOption.find(params[:ticket_option_id]).price
    @payment_cents = @payment_amount * 100
  end

  def spectator
    @payment_amount = TicketOption.find(params[:ticket_option_id]).price
    @payment_cents = @payment_amount * 100
  end

  def sponsor
    @payment_amount = SponsorOption.find(params[:sponsor_option_id].to_i).price
    @payment_cents = @payment_amount * 100
  end
end

