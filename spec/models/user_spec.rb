require 'rails_helper'

RSpec.describe User do
  context 'User should be created' do
    it "is valid with full columns" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
