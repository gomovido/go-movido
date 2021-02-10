require 'rails_helper'

RSpec.describe User do
  context 'User should be created' do
    it "is not valid without a first_name" do
      user = User.new(first_name: "test", last_name: "test", email: 'test@test.com')
      expect(user).to be_valid
    end
  end
end
