require 'rails_helper'

RSpec.describe "Registration", type: :feature do
  describe "User registration", :headless_chrome do
    let(:user_email) { 'johndoe@gmail.com' }
    let(:user_first_name) { 'john' }
    let(:user_last_name) { 'doe' }
    let(:user_password) { 'movido123456!' }
    let(:user_password_confirmation) { 'movido123456!' }

    before do
      visit new_user_registration_path
      within("#new_user") do
        fill_in 'user_email', with: user_email
        fill_in 'user_first_name', with: user_first_name
        fill_in 'user_last_name', with: user_last_name
        fill_in 'user_password', with: user_password
        fill_in 'user_password_confirmation', with: user_password_confirmation
      end
      click_button 'Sign up'
    end

    it "shows welcome message" do
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it "confirms user" do
      expect(User.where(email: user_email)).to exist
    end
  end
end
