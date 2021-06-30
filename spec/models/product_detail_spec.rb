require 'rails_helper'

RSpec.describe ProductDetail, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    let(:pack) { create(:pack) }
    let(:country) { create(:country, :fr) }
    let(:company) { create(:company, :mobile) }
    let(:category) { create(:category, :mobile, pack: pack) }
    let(:product) { create(:product, :mobile, country: country, company: company, category: category) }
    let(:product_detail) { build(:product_detail, product: product) }

    it { is_expected.to validate_presence_of(:content) }

    it 'saves successfully' do
      expect(product_detail.save).to eq(true)
    end
  end
end
