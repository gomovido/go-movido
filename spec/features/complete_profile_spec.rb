require 'rails_helper'

RSpec.feature "Complete Profile", :type => :feature do
  describe "User take a subscription", :headless_chrome do
    let!(:user) { create(:user) }
    let!(:country) { create(:country, [:fr, :gb].sample) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) {create(:company)}
    let!(:person) { build(:person, country.code.to_sym) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:product) {create(:product, category: category, company: company, country: country)}
    let!(:product_feature) {create(:product_feature, product: product)}

    before :each do
      login_as(user, :scope => :user)
      visit category_products_path(product.category)
      click_on 'Select offer'
    end

    it "should be redirected to complete profile"  do
      expect(page).to have_content('Please complete your profile')
    end

    it "should create the person"  do
      country_code = IsoCountryCodes.find(country.code).calling
      within("#new_person") do
        fill_in 'person_phone', with: person.phone.gsub(country_code, '')
        fill_in 'person_birthdate', with: person.birthdate
        fill_in 'person_birth_city', with: person.birth_city
        find('.ap-suggestion', match: :first).click
      end
      sleep 2
      click_button 'Continue'
      expect(user.person).to eq(Person.find_by(phone: person.phone))
    end
    it "should display form errors" do
      click_button 'Continue'
      expect(page).to have_css('.invalid-feedback')
    end
  end
end
