class Tournament < ApplicationRecord
	# not sure what is the limit of a typical golf tournament,
	# this is just random
	validates :player_limit, :inclusion => 2..100

  has_many :teams
  has_many :sponsors
  has_many :admins
  has_many :players, through: :teams
  has_many :reg_sponsors
  has_many :sponsor_options
  has_many :ticket_options

  validates :title, presence: true
  validates :title, uniqueness: { message: "%{value} already exists" }
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validate :start_before_end

  # Validations
  def start_before_end
    if start_datetime >= end_datetime
      errors.add(:start_datetime, 'must be before end')
      errors.add(:end_datetime, 'must be before start')
    end
  end
end
