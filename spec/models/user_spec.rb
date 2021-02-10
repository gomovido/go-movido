require 'rails_helper'

RSpec.describe User do
  context 'User should have first_name, last_name & email' do
    it "is not valid without a first_name" do
      user = User.new(first_name: nil)
      expect(user).to_not be_valid
    end
  end
end
