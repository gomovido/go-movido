require 'rails_helper'

RSpec.describe User do
  subject(:user) { build(:user) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_one(:house) }
    it { is_expected.to have_many(:orders) }
  end

  context "with validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value(user.email).for(:email) }
    it { is_expected.not_to allow_value("not-an-email").for(:email) }
  end
end
