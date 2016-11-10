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
