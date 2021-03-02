require 'rails_helper'

RSpec.feature "Desktop - Company name", type: :feature do
  describe "Check companies on products cards", :headless_chrome do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) { create(:company) }
    let!(:country) { create(:country, [:fr, :gb].sample) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:mobile) {create(:mobile, :internet_and_call, category: category, company: company, country: country)}
    let!(:product_feature) {create(:product_feature, mobile: mobile)}

    before :each do
      login_as(user, :scope => :user)
      visit category.path_to_index
    end

    it "should display company name " do
      expect(page).to have_content(company.name)
    end

    it "should display company logo" do
      expect(page).to have_css("img[src*='#{company.logo_url}']")
    end
  end
end
