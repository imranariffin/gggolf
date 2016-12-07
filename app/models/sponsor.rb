class Sponsor < ApplicationRecord
  attr_accessor :logo 
  belongs_to :user
  belongs_to :tournament
  has_one :sponsor_option
  mount_uploader :logo , SponsorLogoUploader
end