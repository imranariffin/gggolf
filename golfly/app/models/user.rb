class User < ApplicationRecord
  has_many :players
  has_many :sponsors
  has_many :admins
  has_many :teams, through: :players

  def name
    "#{fname} #{lname}"
  end
end
