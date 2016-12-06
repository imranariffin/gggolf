class RemoveUserIdFromTournaments < ActiveRecord::Migration[5.0]
  def change
    remove_column :tournaments, :user_id, :integer
  end
end
