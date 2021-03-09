require 'rails_helper'

RSpec.describe ProductFeature, type: :model do
  subject(:product_feature) { described_class.new }

  let!(:category) { create(:category, :mobile) }
  let!(:company) { create(:company) }
  let!(:category_wifi) { create(:category, :wifi) }
  let!(:country) { create(:country, %i[fr gb].sample) }
  let!(:mobile) { create(:mobile, :internet_and_call, category: category, company: company, country: country) }
  let!(:wifi) { create(:wifi, category: category_wifi, company: company, country: country) }

  describe 'associations' do
    it { is_expected.to belong_to(:mobile).optional }
    it { is_expected.to belong_to(:wifi).optional }
  end

  describe 'validations' do
    it 'validates presence of name' do
      product_feature.assign_attributes(description: 'desc', name: nil, mobile: mobile)
      expect(product_feature.save).to eq(false)
    end

    it 'validates presence of description' do
      product_feature.assign_attributes(description: nil, name: 'name', mobile: mobile)
      expect(product_feature.save).to eq(false)
    end

    context 'when validates presence of only one belongs_to association' do
      it 'does not save' do
        product_feature = build(:product_feature, mobile: mobile, wifi: wifi)
        expect(product_feature.save).to eq(false)
      end
    end

    context 'when validates presence at least of one belongs_to association' do
      it 'saves' do
        product_feature = build(:product_feature, mobile: mobile)
        expect(product_feature.save!).to eq(true)
      end
    end
  end
end
