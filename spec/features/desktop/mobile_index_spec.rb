require 'rails_helper'

RSpec.describe "Desktop - Mobile", type: :feature do
  describe "Check mobile index", :headless_chrome do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) { create(:company) }
    let!(:country) { create(:country, %i[fr gb].sample) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:mobile) { create(:mobile, :internet_and_call, category: category, company: company, country: country) }
    let!(:product_feature) { create(:product_feature, mobile: mobile) }
    let!(:special_offer) { create(:special_offer, mobile: mobile) }

    before do
      login_as(user, scope: :user)
      visit category.path_to_index
    end

    it "displays name" do
      expect(page).to have_content(mobile.name)
    end

    it "displays price" do
      expect(page).to have_content(mobile.format_price)
    end

    it "displays call limit" do
      expect(page).to have_content(mobile.call)
    end

    it "displays area" do
      expect(page).to have_content(mobile.area)
    end

    it "displays special offer" do
      expect(page).to have_content(mobile.special_offers.first.name)
    end

    it "displays modal" do
      click_on 'See details'
      sleep 1
      expect(page).to have_content(mobile.product_features.first.name)
    end
  end
end
