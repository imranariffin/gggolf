class CreateContactPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_players do |t|

      t.timestamps
    end
  end
end
