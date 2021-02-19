require 'rails_helper'

RSpec.feature "Profile", :type => :feature do
  describe "User visit profile", :headless_chrome do
    let!(:user) { create(:user) }
    let!(:country) { create(:country, [:fr, :gb].sample) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:person) { create(:person, country.code.to_sym, user: user) }

    before :each do
      login_as(user, :scope => :user)
      visit user_path(user, active_tab: 'profile', locale: 'en')
    end

    context 'when user want to visit his profile' do

      it "should redirect to the profile tabs"  do
        expect(page).to have_content('My details')
      end

      it "should display user's profile details"  do
        expect(page).to have_field('First name', with: user.first_name)
        expect(page).to have_field('Surname', with: user.last_name)
        expect(page).to have_field('E-mail', with: user.email)
        expect(page).to have_field('Phone', with: user.person.phone)
        expect(page).to have_field('Date of birth', with: user.person.birthdate.strftime('%d-%m-%Y'))
        expect(page).to have_field('City of birth', with: user.person.birth_city)
      end
    end

    context 'when user want to update his profile' do

      it "should update user"  do
        new_user_email = 'new_email@gmail.com'
        new_user_first_name = 'new_first_name'
        new_user_last_name = 'new_last_name'
        within("#profile") do
          fill_in 'user_email', with: new_user_email
          fill_in 'user_first_name', with: new_user_first_name
          fill_in 'user_last_name', with: new_user_last_name
        end
        expect {
          click_button 'Update'
          sleep 2
          user.reload
        }.to change { user.email }.to(new_user_email)
         .and change { user.first_name }.to(new_user_first_name)
         .and change { user.last_name }.to(new_user_last_name)
      end

      it "should display the right callsign" do
        find('.iti__selected-flag').click
        find("#{'.iti_country[data-country-code="' + country.code + '"]'}", visible: false).click
        country_code = IsoCountryCodes.find(country.code).calling
        sleep 2
        expect(page).to have_field('Phone', with: country_code)
      end

      it "should update person"  do
        find('input.datepicker').click
        find('.numInput').fill_in with: 1992
        find('option[value="7"]').click
        find('span[aria-label="August 14, 1992"]').click
        new_user_person_birthdate = Date.new(1992, 8, 14)
        new_user_person_phone = '+447520643110'
        new_user_person_birth_city = 'Paris 15e Arrondissement, Paris, Île-de-France, France'
        within("#profile") do
          fill_in 'user_person_attributes_phone', with: new_user_person_phone
          fill_in 'user_person_attributes_birth_city', with: new_user_person_birth_city
          find('.ap-suggestion').click
          sleep 2
        end
        expect {
          click_button 'Update'
          sleep 2
          user.person.reload
        }.to change { user.person.phone }.to(new_user_person_phone)
          .and change { user.person.birthdate }.to(new_user_person_birthdate)
          .and change { user.person.birth_city }.to(new_user_person_birth_city)
      end
    end
  end
end
