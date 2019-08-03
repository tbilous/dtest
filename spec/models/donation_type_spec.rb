require 'rails_helper'

RSpec.describe DonationType, type: :model do
  it { should have_many(:donations) }
end
