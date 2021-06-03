require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:product_details) }
    it { is_expected.to have_many(:items) }
  end

  describe 'validations' do
    let(:product) { build(:product) }

    %i[name sku description currency activation_price subscription_price].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it 'saves successfully' do
      expect(product.save).to eq(true)
    end
  end
end
