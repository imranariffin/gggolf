class Tournament < ApplicationRecord
  has_many :teams
  has_many :sponsors
  has_many :admins
  has_many :players, through: :teams
end
