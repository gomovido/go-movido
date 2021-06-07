require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:products) }
    it { is_expected.to have_one(:service) }
  end

  describe 'validations' do
    let(:category) { build(:category, :mobile) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    it 'saves successfully' do
      expect(category.save).to eq(true)
    end

    it 'sets the right sku' do
      category.save
      expect(category.sku).to eq("mobile_phone")
    end
  end
end
