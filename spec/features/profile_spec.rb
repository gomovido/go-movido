require 'rails_helper'

RSpec.feature "Profile", :type => :feature do
  describe "User take a subscription", :js do
    let!(:user) { create(:user) }
    let!(:person) { create(:person, user: user) }
    let!(:address) { create(:address, user: user) }

    before :each do
      login_as(user, :scope => :user)
    end

    it "should redirect to the profile tabs"  do
      visit user_path(user, active_tab: 'profile')
      expect(page).to have_content('My profile')
    end

    it "should display user's profile details"  do
      visit user_path(user, active_tab: 'profile')
      find('.iti__selected-flag').click
      save_and_open_screenshot
    end
  end
end
