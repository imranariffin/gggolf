class CreateSponsorOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsor_options do |t|
      t.text :type
      t.decimal :price
      t.integer :tournament_id, :references => [:tournament, :id]

      t.timestamps
    end
  end
end
