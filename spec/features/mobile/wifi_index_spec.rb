require 'rails_helper'

RSpec.describe "Mobile - Wifi", type: :feature do
  describe "Check wifi index", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :wifi) }
    let!(:company) { create(:company) }
    let!(:country) { create(:country, %i[fr gb].sample) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:wifi) { create(:wifi, category: category, company: company, country: country) }
    let!(:product_feature) { create(:product_feature, wifi: wifi) }
    let!(:special_offer) { create(:special_offer, wifi: wifi) }

    before do
      login_as(user, scope: :user)
      visit category.path_to_index
    end

    it "displays name" do
      expect(page).to have_content(wifi.name)
    end

    it "displays price" do
      expect(page).to have_content(wifi.format_price)
    end

    it "displays setup price" do
      expect(page).to have_content(wifi.format_setup_price)
    end

    it "displays area" do
      expect(page).to have_content(wifi.area)
    end

    it "displays dropdown card" do
      find('.product-card', match: :first).click
      sleep 1
      expect(page).to have_content(special_offer.name)
      expect(page).to have_content(product_feature.name)
    end
  end
end
