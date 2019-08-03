class User < ApplicationRecord
  devise :database_authenticatable,  :rememberable, :validatable, :registerable

  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?
  has_many :donations, dependent: :nullify

  private

  def set_default_role
    self.role ||= :user
  end
end
