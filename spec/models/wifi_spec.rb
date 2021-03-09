require 'rails_helper'

RSpec.describe Wifi, type: :model do
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
    %i[name area price time_contract setup_price data_speed].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    it { is_expected.not_to allow_value(nil).for(:active) }
  end
end
