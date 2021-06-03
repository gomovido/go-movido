require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:products) }
  end

  describe 'validations' do
    let(:category) { build(:category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:sku) }
    it { is_expected.to validate_uniqueness_of(:sku).case_insensitive }
    it { is_expected.to validate_presence_of(:description) }

    it 'saves successfully' do
      expect(category.save).to eq(true)
    end
  end
end
