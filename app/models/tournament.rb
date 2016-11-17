class Tournament < ApplicationRecord
	# not sure what is the limit of a typical golf tournament,
	# this is just random
	validates :player_limit, :inclusion => 2..100

  has_many :teams
  has_many :sponsors
  has_many :admins
  has_many :players, through: :teams
end
