class TicketOption < ApplicationRecord
  belongs_to :tournament
  has_many :tickets
end
