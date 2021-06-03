require 'rails_helper'

RSpec.describe UserPreference, type: :model do
  subject(:user_preference) { build(:user_preference) }

  describe 'associations' do
    it { is_expected.to have_one(:cart) }
    it { is_expected.to have_many(:services) }
    it { is_expected.to belong_to(:country) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:arrival) }
    it { is_expected.to validate_presence_of(:stay_duration) }
    it { is_expected.to allow_value(user_preference.arrival).for(:arrival) }
    it { is_expected.not_to allow_value(Faker::Date.backward(days: 30)).for(:arrival) }
    it { is_expected.not_to allow_value("fakedate").for(:arrival) }
  end
end
