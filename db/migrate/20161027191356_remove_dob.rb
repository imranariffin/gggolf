class RemoveDob < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :dob
  end
end
