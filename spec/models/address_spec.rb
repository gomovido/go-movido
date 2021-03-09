require 'rails_helper'

RSpec.describe Address, type: :model do
  let!(:country) { create(:country, %i[fr gb].sample) }
  let!(:user) { create(:user) }

  describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:country) }
  end

  describe 'validations' do
    context 'when user has an address' do
      it 'works with a french or uk address' do
        address = build(:address, country.code.to_sym, country: country, user: user)
        address.algolia_country_code = country.code
        expect(address.supported_country?(address.algolia_country_code)).to be true
      end

      it 'does not work with an unsupported address' do
        address = build(:address, :pr, country: country, user: user)
        address.algolia_country_code = 'pr'
        expect(address.supported_country?(address.algolia_country_code)).to be false
      end

      it 'is a complete address' do
        address = build(:address, country.code.to_sym, country: country, user: user)
        expect(address.complete?).to be true
      end

      it 'is not a complete address' do
        subject = build(:address, country: country, user: user)
        expect(subject.complete?).to be false
      end
    end

    context "when user doesn't have address details" do
      it 'does not have city/zipcode & address' do
        address = build(:address, country: country, user: user)
        expect(address.city).to eq(nil)
        expect(address.zipcode).to eq(nil)
        expect(address.street).to eq(nil)
      end
    end
  end
end
