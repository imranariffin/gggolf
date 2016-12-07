class SponsorOption < ApplicationRecord
  belongs_to :tournament, optional: true
end
