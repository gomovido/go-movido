require 'rails_helper'

RSpec.describe Wifi, type: :model do
  describe 'associations' do
    it { should have_many(:subscriptions) }
    it { should have_many(:product_features) }
    it { should have_many(:special_offers) }
    it { should belong_to(:category) }
    it { should belong_to(:company) }
    it { should belong_to(:country) }
  end
  describe 'validations' do
    [:name, :area, :price, :time_contract, :setup_price, :data_speed].each do |field|
      it { should validate_presence_of(field) }
    end
    it { should_not allow_value(nil).for(:active) }
  end
end
