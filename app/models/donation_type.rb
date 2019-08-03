class DonationType < ApplicationRecord
  has_many :donations, dependent: :nullify

  validates_presence_of :name
end
