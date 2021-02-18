require 'rails_helper'

RSpec.feature "Complete Profile", :type => :feature do
  describe "User take a subscription", :headless_chrome do
    let!(:user) { create(:user) }
    let!(:person) { build(:person, "from_#{user.country.gsub(' ', '_').downcase}".to_sym) }
    let!(:address) { create(:address, "from_#{user.country.gsub(' ', '_').downcase}".to_sym, user: user) }
    let!(:category) { create(:category) }
    let!(:company) {create(:company)}
    let!(:product) {create(:product, "from_#{user.country.gsub(' ', '_').downcase}".to_sym, category: category, company: company)}
    let!(:product_feature) {create(:product_feature, product: product)}

    before :each do
      login_as(user, :scope => :user)
      visit category_products_path(product.category)
      click_on 'Select offer'
    end

    it "should be redirect to complete profile"  do
      expect(page).to have_content('Please complete your profile')
    end

    it "should create the person"  do
      country_code = IsoCountryCodes.search_by_name(user.country)[0].calling
      within("#new_person") do
        fill_in 'person_phone', with: person.phone.gsub(country_code, '')
        fill_in 'person_birthdate', with: person.birthdate
        fill_in 'person_birth_city', with: person.birth_city
      end
      click_button 'Continue'
      expect(user.person).to eq(Person.find_by(phone: person.phone))
    end
    it "should display form errors" do
      click_button 'Continue'
      expect(page).to have_css('.invalid-feedback')
    end
  end
end
