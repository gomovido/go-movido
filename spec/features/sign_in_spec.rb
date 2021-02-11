require 'rails_helper'

RSpec.feature "Sign In", :type => :feature do
  let!(:user) { create(:user) }
  scenario "User should be able to sign in" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
    end
    click_button 'Login'
    assert_equal "/users/#{user.id}/addresses/new", page.current_path
    save_and_open_page
  end
end
