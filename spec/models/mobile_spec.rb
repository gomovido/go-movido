require 'rails_helper'

RSpec.describe Mobile, type: :model do
  describe 'associations' do
    it { should have_many(:subscriptions) }
    it { should have_many(:product_features) }
    it { should have_many(:special_offers) }
    it { should belong_to(:category) }
    it { should belong_to(:company) }
    it { should belong_to(:country) }
  end

  describe 'validations' do
    [:name, :area, :price, :offer_type, :time_contract, :sim_card_price,
      :active, :sim_needed].each do |field|
      it { should validate_presence_of(field) }
    end
    context 'should validates presence of data & data unit' do
      before { allow(subject).to receive(:offer_type).and_return('internet_only') }
      it { should validate_presence_of(:data) }
      it { should validate_presence_of(:data_unit) }
      it { should_not validate_presence_of(:call) }
    end
    context 'should validates presence of call' do
      before { allow(subject).to receive(:offer_type).and_return('call_only') }
      it { should validate_presence_of(:call) }
      it { should_not validate_presence_of(:data) }
      it { should_not validate_presence_of(:data_unit) }
    end
    context 'should validates presence of call & data & data unit' do
      before { allow(subject).to receive(:offer_type).and_return('internet_and_call') }
      it { should validate_presence_of(:call) }
      it { should validate_presence_of(:data) }
      it { should validate_presence_of(:data_unit) }
    end
  end
end
