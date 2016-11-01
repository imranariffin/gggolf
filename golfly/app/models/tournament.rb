class Tournament < ApplicationRecord
  has_many :teams
  has_many :sponsors
  has_many :admins
  has_many :players, through: :teams
  has_many :reg_sponsors
  has_many :sponsor_options
  has_many :ticket_options
end
