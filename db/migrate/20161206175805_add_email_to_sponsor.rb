class AddEmailToSponsor < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsors, :email, :String
  end
end
