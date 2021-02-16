require 'rails_helper'

RSpec.feature "Complete Profile", :type => :feature do
  describe "User take a subscription", :js do
    let!(:user) { create(:user) }
    let(:person) { build(:person) }
    let!(:address) { create(:address, user: user) }
    let!(:category) { create(:category) }
    let!(:product) {create(:product, category: category)}
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
      within("#new_person") do
        fill_in 'person_phone', with: person.phone.gsub('+33', '')
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
