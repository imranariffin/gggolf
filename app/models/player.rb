class Player < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :scores

  def total_score
    scores.sum(:strokes)
  end
end
