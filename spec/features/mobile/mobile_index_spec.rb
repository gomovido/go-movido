require 'rails_helper'

RSpec.feature "Mobile - Mobile#Index", type: :feature do
  describe "Check mobile index", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) { create(:company) }
    let!(:country) { create(:country, [:fr, :gb].sample) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:mobile) {create(:mobile, :internet_and_call, category: category, company: company, country: country)}
    let!(:product_feature) {create(:product_feature, mobile: mobile)}
    let!(:special_offer) {create(:special_offer, mobile: mobile)}

    before :each do
      login_as(user, :scope => :user)
      visit category.path_to_index
    end

    it "should display name" do
      expect(page).to have_content(mobile.name)
    end

    it "should display price" do
      expect(page).to have_content(mobile.format_price)
    end

    it "should display call limit" do
      expect(page).to have_content(mobile.call)
    end

    it "should display area" do
      expect(page).to have_content(mobile.area)
    end

    it "should display open dropdown product card" do
      find('.product-card', match: :first).click
      sleep 1
      expect(page).to have_content(mobile.special_offers.first.name)
      expect(page).to have_content(mobile.product_features.first.name)
    end
  end
end
