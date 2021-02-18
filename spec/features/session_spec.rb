require 'rails_helper'

RSpec.feature "Session", :type => :feature do
  describe "User Sign in", :headless_chrome do
    let(:user) { create(:user) }

    before :each do
      visit new_user_session_path
      within("#new_user") do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
      end
      click_button 'Login'
    end
    it "shows welcome message" do
      expect(page).to have_content('Logged in successfully.')
    end
    it "shows addresses new" do
      assert_equal "/users/#{user.id}/addresses/new", page.current_path
    end
  end
end
