require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:country) }
    it { is_expected.to have_many(:product_details) }
    it { is_expected.to have_many(:items) }
  end

  describe 'validations' do
    let(:pack) { create(:pack) }
    let(:country) { create(:country, :fr) }
    let(:company) { create(:company, :mobile) }
    let(:category) { create(:category, :mobile, pack: pack) }
    let(:product) { build(:product, :mobile, country: country, company: company, category: category) }

    %i[description name activation_price subscription_price image_url].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it 'saves successfully' do
      expect(product.save).to eq(true)
    end

    it 'sets an sku' do
      product.save
      expect(product.sku).to eq("fr_sfr_mobile_phone_bouygues")
    end
  end
end
