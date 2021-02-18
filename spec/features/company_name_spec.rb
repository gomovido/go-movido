require 'rails_helper'

RSpec.feature "Company name", type: :feature do
  describe "Check companies on products cards", :headless_chrome do
    let!(:user) { create(:user) }
    let!(:person) { build(:person, "from_#{user.country.gsub(' ', '_').downcase}".to_sym) }
    let!(:category) { create(:category) }
    let!(:company) { create(:company) }
    let!(:product) {create(:product, "from_#{user.country.gsub(' ', '_').downcase}".to_sym, category: category, company: company)}
    let!(:address) { create(:address, "from_#{user.country.gsub(' ', '_').downcase}".to_sym, user: user) }
    let!(:product_feature) {create(:product_feature, product: product)}

    before :each do
      login_as(user, :scope => :user)
      visit category_products_path(product.category)
    end

    it "should display company names" do
      expect(page).to have_content('SFR')
    end

    it "should not have broken images" do
      expect(page).to have_css("img[src*='SFR']")
    end
  end
end
