require 'rails_helper'

RSpec.describe "Desktop - Complete Profile", type: :feature do
  describe "User take a subscription", :headless_chrome do
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
      click_on 'Select offer'
    end

    it "is redirected to complete profile" do
      expect(page).to have_content('Please complete your profile')
    end

    it "creates the person" do
      country_code = IsoCountryCodes.find(country.code).calling
      sleep 2
      within("#new_person") do
        fill_in 'person_phone', with: "#{country_code}#{person.phone.gsub(country_code, '')}"
        fill_in 'person_birth_city', with: person.birth_city
        sleep 1
        find('.ap-suggestion', match: :first).click
      end
      new_user_person_birthdate = Date.new(1992, 8, 14)
      find('input.datepicker').click
      find('.numInput').fill_in with: new_user_person_birthdate.year
      find("option[value='#{new_user_person_birthdate.month - 1}']", visible: false).click
      find("span[aria-label='#{new_user_person_birthdate.strftime('%B %e, %Y')}']").click
      click_button 'Continue'
      expect(Person.where(user: user).count).to eq(1)
    end

    it "displays form errors" do
      click_button 'Continue'
      expect(page).to have_css('.invalid-feedback')
    end
  end
end
