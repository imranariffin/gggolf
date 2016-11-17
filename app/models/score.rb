class Score < ApplicationRecord
  belongs_to :player

  validates :hole, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :strokes, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
