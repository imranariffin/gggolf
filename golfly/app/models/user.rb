class User < ApplicationRecord
  has_many :players
  has_many :sponsors
  has_many :admins
  has_many :teams, through: :players

  validates :fname, presence: true
  validates :lname, presence: true
  validates :email, presence: true
  validates :dob, presence: true

  def name
    "#{fname} #{lname}"
  end
end
