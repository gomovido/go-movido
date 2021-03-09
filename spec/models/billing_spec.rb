require 'rails_helper'

RSpec.describe Billing, type: :model do
  subject(:billing) { described_class.new }

  let!(:user) { create(:user) }
  let!(:category) { create(:category, :mobile) }
  let!(:company) { create(:company) }
  let!(:country_fr) { create(:country, :fr) }
  let!(:country_gb) { create(:country, :gb) }
  let!(:address_fr) { create(:address, :fr, country: country_fr, user: user) }
  let!(:address_gb) { create(:address, :gb, country: country_gb, user: user) }
  let!(:mobile_fr) { create(:mobile, :internet_and_call, category: category, company: company, country: country_fr) }
  let!(:mobile_gb) { create(:mobile, :internet_and_call, category: category, company: company, country: country_gb) }
  let!(:product_feature) { create(:product_feature, mobile: mobile_fr) }
  let!(:special_offer) { create(:special_offer, mobile: mobile_fr) }
  let!(:subscription_fr) { create(:subscription, :fr, address: address_fr, product: mobile_fr) }
  let(:subscription_gb) { create(:subscription, :gb, address: address_gb, product: mobile_gb) }

  describe "Validations" do
    %i[bank address holder_name iban].each do |field|
      it "valides presence of #{field}" do
        billing.subscription = subscription_fr
        expect(billing).to validate_presence_of(field)
      end
    end

    it 'validates correct billing fields for uk' do
      billing.subscription = subscription_gb
      expect(billing).to validate_presence_of(:account_number)
      expect(billing).to validate_presence_of(:sort_code)
    end

    it 'validates correct billing fields for eu' do
      billing.subscription = subscription_fr
      expect(billing).to validate_presence_of(:bic)
    end

    it 'validates throw error if billing address is not in france' do
      billing.subscription = subscription_fr
      billing.address = address_gb.street
      expect(billing).not_to be_valid
      expect(billing.errors.messages[:address]).to eq ["needs to be in #{country_fr.name}"]
    end

    it 'validates throw error if billing address is not in uk' do
      billing.subscription = subscription_gb
      billing.address = address_fr.street
      expect(billing).not_to be_valid
      expect(billing.errors.messages[:address]).to eq ["needs to be in #{country_gb.name}"]
    end

    it "unvalidates fake/wrong IBAN" do
      billing.subscription = subscription_fr
      billing.address = address_fr.street
      billing.user = user
      billing.holder_name = user.first_name
      billing.iban = 'FR77357383583'
      expect(billing.valid?).to eq(false)
    end

    it "validates billing with a correct IBAN" do
      billing = described_class.new(subscription: subscription_fr, address: address_fr.street, algolia_country_code: 'fr', user: user,
                                    holder_name: user.first_name, iban: 'FR7630006000011234567890189')
      billing.valid?
      expect(billing.save).to eq(true)
    end

    it "validates billing with a correct Sort Code & account_number" do
      billing = described_class.new(subscription: subscription_gb, address: address_gb.street, algolia_country_code: 'gb', user: user,
                                    holder_name: user.first_name, sort_code: '090127', account_number: '93496333')
      billing.valid?
      expect(billing.save).to eq(true)
    end
  end
end
