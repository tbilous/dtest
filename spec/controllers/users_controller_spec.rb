require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #home' do
    let(:user) { create :user }
    let(:type) { create :donation_type }
    let!(:donations) { create_list(:donation, 5, user: user, donation_type: type, date: Date.current) }

    subject { get :show, params: { id: user.id } }

    include_context 'authorized user'

    it 'response should to contain user donations' do
      subject
      expect(assigns(:donations)).to match_array donations
    end
  end
end
