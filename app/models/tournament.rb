  class Tournament < ApplicationRecord
	# not sure what is the limit of a typical golf tournament,
	# this is just random
	validates :player_limit, :inclusion => 2..144
  validates :title, presence: true
  validates :title, uniqueness: { message: "%{value} already exists" }
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validate :start_before_end

  mount_uploader :logo , TournamentLogoUploader

  has_many :teams
  has_many :sponsors
  has_many :admins
  has_many :players, through: :teams
  has_many :reg_sponsors
  has_many :sponsor_options
  has_many :ticket_options

  accepts_nested_attributes_for :sponsor_options, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :ticket_options, allow_destroy: true, reject_if: :all_blank

  # Validations
  def start_before_end
    return if start_datetime.blank? || end_datetime.blank?
    if start_datetime > end_datetime
      errors.add(:end_datetime, 'must be before start')
    end
  end

  def has_player? user_id
    players.exists? user_id: user_id
  end

  def has_sponsor? user_id
    sponsors.exists? user_id: user_id
  end

  def has_admin? user_id
    admins.exists? user_id: user_id
  end

  def player_availability
    (player_limit.to_f - players.size) / player_limit * 100
  end

  def has_sponsor? user_id
    sponsors.pluck(:user_id).include? user_id
  end

  def has_admin? user_id
    admins.pluck(:user_id).include? user_id
  end
end
