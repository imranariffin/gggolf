class AddSponsorOptionsToSponsors < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsors, :sponsor_opt_id, :integer
  end
end
