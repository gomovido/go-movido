require 'rails_helper'

RSpec.describe User do
  subject { build(:user) }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  context "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:email) }
    it { should allow_value(subject.email).for(:email) }
    it { should_not allow_value("not-an-email").for(:email) }
  end

  context "instance method" do
    let(:user) { create(:user) }
    let!(:country) { create(:country, [:fr, :gb].sample) }

    it 'is expected to validate that the user profil is complete' do
      create(:person, country.code.to_sym, user: user)
      expect(user.is_complete?).to be true
    end

    it 'is expected to validate that the user profil is uncomplete' do
      expect(user.is_complete?).to be false
    end
  end
end
