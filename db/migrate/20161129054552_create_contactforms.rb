class CreateContactforms < ActiveRecord::Migration[5.0]
  def change
    create_table :contactforms do |t|

      t.timestamps
    end
  end
end
