require 'rails_helper'

RSpec.describe "Mobile - Credentials", type: :feature do
  let!(:user) { create(:user) }

  describe "User visits account page", :headless_mobile do
    before do
      login_as(user, scope: :user)
      visit edit_user_registration_path
      within('#edit_user') do
        fill_in 'user_email', with: 'coucou@cou.cool'
      end
    end

    it 'is not able to modify password / email without putting current password' do
      click_on 'Update'
      expect(page).to have_css('.invalid-feedback')
    end

    it 'is able to modify password / email by putting current password' do
      within('#edit_user') do
        fill_in 'user_current_password', with: '1234567'
      end
      expect do
        click_on 'Update'
        user.reload
      end.to change(user, :email).to('coucou@cou.cool')
    end

    it 'is able to destroy account' do
      accept_confirm do
        click_link 'Delete account'
      end
      expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
    end
  end
end
