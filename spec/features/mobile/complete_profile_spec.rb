require 'rails_helper'

RSpec.describe "Mobile - Complete Profile", type: :feature do
  describe "User take a subscription", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:country) { create(:country, %i[fr gb].sample) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) { create(:company) }
    let!(:person) { build(:person, country.code.to_sym) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:mobile) { create(:mobile, :internet_and_call, category: category, company: company, country: country) }
    let!(:product_feature) { create(:product_feature, mobile: mobile) }

    before do
      login_as(user, scope: :user)
      visit category.path_to_index
      find('.product-card', match: :first).click
      sleep 1
      click_on 'Select offer'
      sleep 1
    end

    it "creates the person" do
      country_code = IsoCountryCodes.find(country.code).calling
      within("#new_person") do
        fill_in 'person_phone', with: "#{country_code}#{person.phone.gsub(country_code, '')}"
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
  end
end
