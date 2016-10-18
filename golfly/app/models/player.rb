class Player < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :scores
end
