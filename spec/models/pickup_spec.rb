require 'rails_helper'

RSpec.describe Pickup, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
  end

  describe 'validations' do
    let(:user) { create(:user) }
    let(:country) { create(:country, :fr) }
    let(:shipping) { create(:shipping) }
    let(:billing) { create(:billing) }
    let(:charge) { create(:charge) }
    let(:user_preference) { create(:user_preference, user: user, country: country) }
    let(:cart) { create(:cart, user_preference: user_preference) }
    let(:order) { create(:order, user: user, charge: charge, billing: billing, shipping: shipping) }
    let(:pickup) { build(:pickup, order: order) }

    it { is_expected.not_to allow_value(nil).for(:uncomplete) }

    context 'when infos are complete' do
      subject(:pickup) { described_class.new(uncomplete: false) }

      it { is_expected.not_to allow_value(nil).for(:airport) }
      it { is_expected.to validate_presence_of(:arrival) }
      it { is_expected.to validate_presence_of(:flight_number) }
    end

    context 'when infos are uncomplete' do
      subject(:pickup) { described_class.new(uncomplete: true) }

      it { is_expected.not_to validate_presence_of(:airport) }
      it { is_expected.not_to validate_presence_of(:flight_number) }
      it { is_expected.not_to validate_presence_of(:arrival) }
    end

    it { is_expected.to allow_value(pickup.arrival).for(:arrival) }
    it { is_expected.not_to allow_value(Faker::Date.backward(days: 30)).for(:arrival) }
    it { is_expected.not_to allow_value("fakedate").for(:arrival) }

    it { is_expected.to allow_value("Paris CDG").for(:airport) }
    it { is_expected.not_to allow_value("fake_airport").for(:airport) }

    it 'saves successfully' do
      expect(pickup.save).to eq(true)
    end
  end
end
