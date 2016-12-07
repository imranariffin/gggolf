class TicketOption < ApplicationRecord
  belongs_to :tournament, optional: true
  has_many :tickets
end
