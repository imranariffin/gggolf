class Player < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_one :ticket_option
  has_many :scores

  scope :with_user_id, ->(user_id) { where(user_id: user_id) }

  def total_score
    scores.sum(:strokes)
  end
end
