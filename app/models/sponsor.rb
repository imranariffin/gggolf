class Sponsor < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  has_one :sponsor_option
end