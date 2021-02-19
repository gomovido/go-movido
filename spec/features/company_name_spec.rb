require 'rails_helper'

RSpec.feature "Company name", type: :feature do
  describe "Check companies on products cards", :headless_chrome do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:company) { create(:company) }
    let!(:product) {create(:product, "from_#{user.country.gsub(' ', '_').downcase}".to_sym, category: category, company: company)}
    let!(:address) { create(:address, "from_#{user.country.gsub(' ', '_').downcase}".to_sym, user: user) }
    let!(:product_feature) {create(:product_feature, product: product)}

    before :each do
      login_as(user, :scope => :user)
      visit category_products_path(category)
    end

    it "should display company name " do
      expect(page).to have_content(company.name)
    end

    it "should display company logo" do
      expect(page).to have_css("img[src*='#{company.logo_url}']")
    end
  end
end