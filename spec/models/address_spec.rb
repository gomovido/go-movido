require 'rails_helper'

RSpec.describe Address, type: :model do
  let!(:country) { create(:country, %i[fr gb].sample) }
  let!(:user) { create(:user) }

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:country) }
  end

  describe 'validations' do
    context 'user has an address' do
      it 'should work with a french or uk address' do
        address = build(:address, country.code.to_sym, country: country, user: user)
        address.algolia_country_code = country.code
        expect(address.supported_country?(address.algolia_country_code)).to be true
      end
      it 'should not work with an unsupported address' do
        address = build(:address, :pr, country: country, user: user)
        address.algolia_country_code = 'pr'
        expect(address.supported_country?(address.algolia_country_code)).to be false
      end
      it 'should be a complete address' do
        address = build(:address, country.code.to_sym, country: country, user: user)
        expect(address.complete?).to be true
      end
      it 'should not be a complete address' do
        subject = build(:address, country: country, user: user)
        expect(subject.complete?).to be false
      end
    end

    context "user doesn't have address details" do
      it 'should not have city/zipcode & address' do
        subject { build(:address, country: country, user: user) }
        expect(subject.city).to eq(nil)
        expect(subject.zipcode).to eq(nil)
        expect(subject.street).to eq(nil)
      end
    end
  end
end
