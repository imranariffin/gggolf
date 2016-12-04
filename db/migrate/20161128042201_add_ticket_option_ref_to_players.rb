class AddTicketOptionRefToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_reference :players, :ticket_option, foreign_key: true
  end
end
