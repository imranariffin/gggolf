class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.references :player, foreign_key: true
      t.integer :hole
      t.integer :strokes

      t.timestamps
    end
  end
end
