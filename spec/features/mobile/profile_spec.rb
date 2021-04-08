require 'rails_helper'

RSpec.describe "Mobile - Profile", type: :feature do
  describe "User visits profile", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:country) { create(:country, %i[fr gb].sample) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:person) { create(:person, country.code.to_sym, user: user) }

    before do
      login_as(user, scope: :user)
      visit user_path(user, active_tab: 'profile', locale: 'en')
    end

    context 'when user wants to visit his profile' do
      it "displays user's profile details" do
        expect(find('input.flatpickr-mobile').value).to eq(user.person.birthdate.strftime('%Y-%m-%d'))
      end
    end

    context 'when user wants to update his profile' do
      it "updates person" do
        new_user_person_birthdate = Faker::Date.birthday(min_age: 18, max_age: 65)
        find("input.flatpickr-mobile").set(new_user_person_birthdate)
        new_user_person_phone = '+447520643110'
        new_user_person_birth_city = 'Paris 15e Arrondissement, Paris, Île-de-France, France'
        within("#profile") do
          fill_in 'user_person_attributes_phone', with: new_user_person_phone
          fill_in 'user_person_attributes_birth_city', with: new_user_person_birth_city
          find('.ap-suggestion').click
          sleep 2
        end
        expect do
          click_button 'Update'
          sleep 2
          user.person.reload
        end.to change { user.person.phone }.to(new_user_person_phone)
                                           .and change { user.person.birthdate }.to(new_user_person_birthdate)
                                                                                .and change { user.person.birth_city }.to(new_user_person_birth_city)
      end
    end
  end
end
