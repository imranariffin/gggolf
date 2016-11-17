class CreateTournaments < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.string :title
      t.string :location
      t.datetime :start
      t.datetime :end
      t.text :description

      t.timestamps
    end
  end
end
