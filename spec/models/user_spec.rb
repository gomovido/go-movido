require 'rails_helper'

RSpec.describe User do
  subject {
    described_class.new(first_name: "George",
                        last_name: "Floyd",
                        email: 'georgefloyd@test.com',
                        password: '123456')
  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  context "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:email) }
    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("not-an-email").for(:email) }
  end
end
