require 'rails_helper'

RSpec.describe Billing, type: :model do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) { create(:company) }
    let!(:country_fr) { create(:country, :fr) }
    let!(:country_gb) { create(:country, :gb) }
    let!(:address_fr) { create(:address, :fr, country: country_fr, user: user) }
    let!(:address_gb) { create(:address, :gb, country: country_gb, user: user) }
    let!(:mobile_fr) {create(:mobile, :internet_and_call, category: category, company: company, country: country_fr)}
    let!(:mobile_gb) {create(:mobile, :internet_and_call, category: category, company: company, country: country_gb)}
    let!(:product_feature) {create(:product_feature, mobile: mobile_fr)}
    let!(:special_offer) {create(:special_offer, mobile: mobile_fr)}
    let!(:subscription_fr) {create(:subscription, :fr, address: address_fr, product: mobile_fr)}
    let!(:subscription_gb) {create(:subscription, :gb, address: address_gb, product: mobile_gb)}

  describe "Validations" do
    subject { Billing.new(subscription: subscription_fr) }
    [:bank, :address, :bank].each do |field|
      it { should validate_presence_of(field) }
    end
    it 'should validate correct billing fields for uk' do
      subject.subscription = subscription_gb
      expect(subject).to validate_presence_of(:account_number)
      expect(subject).to validate_presence_of(:sort_code)
    end
    it 'should validate correct billing fields for eu' do
      subject.subscription = subscription_fr
      expect(subject).to validate_presence_of(:bic)
    end
    it 'should validate throw error if billing address is not in france' do
      subject.subscription = subscription_fr
      subject.address = address_gb.street
      expect(subject).to_not be_valid
      expect(subject.errors.messages[:address]).to eq ["needs to be in #{country_fr.name}"]
    end
    it 'should validate throw error if billing address is not in uk' do
      subject.subscription = subscription_gb
      subject.address = address_fr.street
      expect(subject).to_not be_valid
      expect(subject.errors.messages[:address]).to eq ["needs to be in #{country_gb.name}"]
    end
    it "should unvalidate fake/wrong IBAN" do
      subject.subscription = subscription_fr
      subject.address = address_fr.street
      subject.user = user
      subject.holder_name = user.first_name
      subject.iban = 'FR77357383583'
      expect(subject.valid?).to eq(false)
    end
    it "should validate billing with a correct IBAN" do
      subject = Billing.new(subscription: subscription_fr, address: address_fr.street, algolia_country_code: 'fr', user: user, holder_name: user.first_name, iban: 'FR7630006000011234567890189')
      subject.valid?
      expect(subject.save).to eq(true)
    end
  end
end
