require 'rails_helper'
RSpec.describe Mobile, type: :model do
  describe 'polymorphic' do
    it { is_expected.to have_many(:subscriptions) }
  end

  describe 'associations' do
    it { should have_many(:product_features) }
    it { should have_many(:special_offers) }
    it { should have_many(:subscriptions) }
    it { should belong_to(:category) }
    it { should belong_to(:company) }
    it { should belong_to(:country) }
  end

  describe 'validations' do
    %i[name area price offer_type time_contract sim_card_price].each do |field|
      it { should validate_presence_of(field) }
    end
    it { should_not allow_value(nil).for(:sim_needed) }
    it { should_not allow_value(nil).for(:active) }

    context 'should validates presence of data' do
      before { allow(subject).to receive(:offer_type).and_return('internet_only') }
      it { should validate_presence_of(:data) }
      it { should_not validate_presence_of(:call) }
    end
    context 'should validates presence of call' do
      before { allow(subject).to receive(:offer_type).and_return('call_only') }
      it { should validate_presence_of(:call) }
      it { should_not validate_presence_of(:data) }
      it { should_not validate_inclusion_of(:data_unit).in_array(['GB', 'MB']) }
    end
    context 'should validates presence of call & data & data unit' do
      before { allow(subject).to receive(:offer_type).and_return('internet_and_call') }
      before { allow(subject).to receive(:data).and_return(20) }
      it { should validate_presence_of(:call) }
      it { should validate_inclusion_of(:data_unit).in_array(['GB', 'MB']) }
    end

    context 'should validates presence data unit unless unlimited data' do
      before { allow(subject).to receive(:offer_type).and_return('internet_and_call') }
      before { allow(subject).to receive(:data).and_return(0) }
      it { should validate_presence_of(:call) }
      it { should_not validate_inclusion_of(:data_unit).in_array(['GB', 'MB']) }
    end
    context 'should validates presence of data' do
      before { allow(subject).to receive(:offer_type).and_return('internet_only') }
      it { should validate_presence_of(:data) }
      it { should_not validate_presence_of(:call) }
    end
  end
end
