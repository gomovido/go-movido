require 'rails_helper'

RSpec.describe "Mobile - Mobile#Index", type: :feature do
  describe "Check mobile index", :headless_mobile do
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

    it "displays open dropdown product card" do
      find('.product-card', match: :first).click
      sleep 1
      expect(page).to have_content(special_offer.name)
      expect(page).to have_content(product_feature.name)
    end
  end
end
