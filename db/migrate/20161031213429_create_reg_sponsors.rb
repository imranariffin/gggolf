class CreateRegSponsors < ActiveRecord::Migration[5.0]
  def change
    create_table :reg_sponsors do |t|
      t.text :name
      t.text :type
      t.text :website
      t.integer :tournament_id, :references => [:tournament, :id]

      t.timestamps
    end
  end
end
