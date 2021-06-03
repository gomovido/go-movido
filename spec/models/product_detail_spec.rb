require 'rails_helper'

RSpec.describe ProductDetail, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    let(:product_detail) { build(:product_detail) }

    it { is_expected.to validate_presence_of(:content) }

    it 'saves successfully' do
      expect(product_detail.save).to eq(true)
    end
  end
end
