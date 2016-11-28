class Tournament < ApplicationRecord
	# not sure what is the limit of a typical golf tournament,
	# this is just random
	validates :player_limit, :inclusion => 2..100
  validates :title, presence: true
  validates :title, uniqueness: { message: "%{value} already exists" }
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :ticket_options, length: { minimum: 1 }

  has_many :teams
  has_many :sponsors
  has_many :admins
  has_many :players, through: :teams
  has_many :reg_sponsors
  has_many :sponsor_options
  has_many :ticket_options

  belongs_to :user
  validate :start_before_end
  

  # Validations
  def start_before_end
    return if start_datetime.blank? || end_datetime.blank?
    if start_datetime > end_datetime
      errors.add(:end_datetime, 'must be before start')
    end
  end

  def has_player? user_id
    players.pluck(:user_id).include? user_id
  end

  def has_sponsor? user_id
    sponsors.pluck(:user_id).include? user_id
  end

  def has_admin? user_id
    admins.pluck(:user_id).include? user_id
  end
end
