require 'rails_helper'

RSpec.describe DonationsController, type: :controller do
  describe 'GET #graph' do
    let(:user) { create :user }
    let(:type) { create :donation_type }
    let(:date1) { Date.tomorrow }
    let(:date2) { Date.current }
    let!(:tomorrow_donations) { create_list(:donation, 2, user: user, donation_type: type, date: date1) }
    let!(:today_donations) { create_list(:donation, 5, user: user, donation_type: type, date: date2) }

    subject { get 'graph', format: :json }

    before { subject }

    it 'response contained grouped by dates data' do
      expect(response.body).to be_json_eql(tomorrow_donations.count.to_json).at_path(date1.to_s)
      expect(response.body).to be_json_eql(today_donations.count.to_json).at_path(date2.to_s)
    end
  end
end
