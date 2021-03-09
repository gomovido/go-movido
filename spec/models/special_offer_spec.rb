require 'rails_helper'

RSpec.describe SpecialOffer, type: :model do
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
      special_offer = described_class.new(name: nil, mobile: mobile)
      expect(special_offer.save).to eq(false)
    end

    context 'when validates presence of only one belongs_to association' do
      it 'does not save' do
        special_offer = build(:special_offer, mobile: mobile, wifi: wifi)
        expect(special_offer.save).to eq(false)
      end
    end

    context 'when validates presence at least of one belongs_to association' do
      it 'saves' do
        special_offer = build(:special_offer, mobile: mobile)
        expect(special_offer.save!).to eq(true)
      end
    end
  end
end
