class Team < ApplicationRecord
  has_many :players
  belongs_to :tournament

  def total_score
    players.joins(:scores).sum(:strokes)
  end
end
