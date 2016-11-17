class CreateTicketOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_options do |t|
      t.string :type
      t.decimal :price
      t.integer :tournament_id, :references => [:tournament, :id]

      t.timestamps
    end
  end
end
