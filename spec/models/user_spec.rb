require 'rails_helper'

RSpec.describe User do
  subject(:user) { build(:user) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  context "with validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value(user.email).for(:email) }
    it { is_expected.not_to allow_value("not-an-email").for(:email) }
  end

  context "with instance method" do
    let(:user) { create(:user) }
    let!(:country) { create(:country, %i[fr gb].sample) }

    it 'is expected to validate that the user profil is complete' do
      create(:person, country.code.to_sym, user: user)
      expect(user.complete?).to be true
    end

    it 'is expected to validate that the user profil is uncomplete' do
      expect(user.complete?).to be false
    end
  end
end
