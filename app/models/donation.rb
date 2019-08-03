class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :donation_type

  validates_presence_of :date
end
