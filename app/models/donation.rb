class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :donation_type

  validates_presence_of :date

  scope :by_types, ->(type) { where(donation_type: type) }
  scope :by_users, ->(user) { where(user_id: user) }

  def self.search(query)
    search_params = {
      donation_type_id: :by_types,
      user_id: :by_users
    }

    result = where(nil)
    search_params.each do |k, v|
      result = result.send(v, query[k]) if query[k].present?
    end
    result
  end
end
