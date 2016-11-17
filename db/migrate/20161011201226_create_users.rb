class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.date :dob
      t.string :phone
      t.string :addr

      t.timestamps
    end
  end
end
