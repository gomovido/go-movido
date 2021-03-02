require 'rails_helper'

RSpec.feature "Mobile - Complete Profile", :type => :feature do
  describe "User take a subscription", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:country) { create(:country, [:fr, :gb].sample) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) {create(:company)}
    let!(:person) { build(:person, country.code.to_sym) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:mobile) {create(:mobile, :internet_and_call, category: category, company: company, country: country)}
    let!(:product_feature) {create(:product_feature, mobile: mobile)}

    before :each do
      login_as(user, :scope => :user)
      visit category.path_to_index
      find('.product-card', match: :first).click
      sleep 1
      click_on 'Select offer'
      sleep 1
    end

    it "should be redirected to complete profile"  do
      expect(page).to have_content('Complete your profile')
    end

    it "should create the person"  do
      country_code = IsoCountryCodes.find(country.code).calling
      within("#new_person") do
        fill_in 'person_phone', with: country_code + '' + person.phone.gsub(country_code, '')
        find("input.flatpickr-mobile").set(person.birthdate)
        fill_in 'person_birth_city', with: person.birth_city
        sleep 1
        find('.ap-suggestion', match: :first).click
      end
      sleep 2
      click_button 'Continue'
      sleep 1
      expect(Person.where(user: user).count).to eq(1)
    end
    it "should display form errors" do
      click_button 'Continue'
      expect(page).to have_css('.invalid-feedback')
    end
  end
end
