class User < ApplicationRecord
  validates :addr, presence: true, length: {minimum:10, maximum: 50}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :players
  has_many :sponsors
  has_many :admins
  has_many :teams, through: :players

  def full_name
  	"#{fname} #{lname}"
  end
end
