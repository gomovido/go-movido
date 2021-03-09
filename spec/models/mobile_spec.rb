require 'rails_helper'
RSpec.describe Mobile, type: :model do
  describe 'polymorphic' do
    it { is_expected.to have_many(:subscriptions) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:product_features) }
    it { is_expected.to have_many(:special_offers) }
    it { is_expected.to have_many(:subscriptions) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:company) }
    it { is_expected.to belong_to(:country) }
  end

  describe 'validations' do
    %i[name area price offer_type time_contract sim_card_price].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    it { is_expected.not_to allow_value(nil).for(:sim_needed) }
    it { is_expected.not_to allow_value(nil).for(:active) }

    context 'with presence of data' do
      subject(:mobile) { described_class.new(offer_type: "internet_only") }

      it { is_expected.to validate_presence_of(:data) }
      it { is_expected.not_to validate_presence_of(:call) }
    end

    context 'with presence of call' do
      subject(:mobile) { described_class.new(offer_type: "call_only") }

      it { is_expected.to validate_presence_of(:call) }
      it { is_expected.not_to validate_presence_of(:data) }
      it { is_expected.not_to validate_inclusion_of(:data_unit).in_array(['GB', 'MB']) }
    end

    context 'with presence of call & data & data unit' do
      subject(:mobile) { described_class.new(offer_type: "internet_and_call", data: 20) }

      it { is_expected.to validate_presence_of(:call) }
      it { is_expected.to validate_inclusion_of(:data_unit).in_array(['GB', 'MB']) }
    end

    context 'with presence data unit unless unlimited data' do
      subject(:mobile) { described_class.new(offer_type: "internet_and_call", data: 0) }

      it { is_expected.to validate_presence_of(:call) }
      it { is_expected.not_to validate_inclusion_of(:data_unit).in_array(['GB', 'MB']) }
    end
  end
end
