class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :ticket_option_id
      t.string :email
      t.boolean :checked_in, default: false

      t.timestamps
    end
  end
end
