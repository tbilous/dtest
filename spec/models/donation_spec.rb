require 'rails_helper'

RSpec.describe Donation, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:donation_type) }

  describe '#search' do
    let(:john) { create :user }
    let(:nik) { create :user }
    let(:types) { create_list :donation_type, 2 }
    let!(:john_donations) do
      types.each do |i|
        create(:donation, user: john, donation_type: i, date: Date.current)
      end
    end

    let!(:nik_donations) do
      types.each do |i|
        create(:donation, user: nik, donation_type: i, date: Date.current)
      end
    end

    context 'where params nil' do
      let(:params) { { user_id: nil, donation_type_id: nil } }
      subject { described_class.search(params) }

      it 'return all donations' do
        expect(is_expected.target).to match_array(Donation.all)
      end
    end

    context 'where params user_id nil donation_type_id query' do
      let(:type) { DonationType.first }
      let(:params) { { user_id: nil, donation_type_id: type.id } }
      subject { described_class.search(params) }

      it 'return all donations' do
        expect(is_expected.target).to match_array(type.donations)
      end
    end

    context 'where params user_id john.id donation_type_id query' do
      let(:type) { DonationType.first }
      let(:params) { { user_id: john.id, donation_type_id: type.id } }
      subject { described_class.search(params) }

      it 'return all donations' do
        expect(is_expected.target).to match_array(type.donations.where(user_id: john.id))
      end
    end
  end
end
