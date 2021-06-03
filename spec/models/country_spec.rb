require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:user_preferences) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
  end
end