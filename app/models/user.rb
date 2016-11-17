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

  validates :fname, presence: true
  validates :lname, presence: true
  validates :email, presence: true

  def name
    "#{fname} #{lname}"
  end

  def player_teams
    Team.joins(:plyers).where(players: { user_id: id }).distinct
  end

  def player_tournaments
    Tournament.joins(teams: :players).where(players: { user_id: id }).distinct
  end

  def admin_tournaments
    Tournament.joins(:admins).where(admins: { user_id: id }).distinct
  end

  def sponsor_tournaments
    Tournament.joins(:sponsors).where(sponsors: { user_id: id }).distinct
  end
end
