require 'rails_helper'

RSpec.describe Person do
  let!(:user) { create(:user) }
  subject { create(:person, user: user) }
  describe "Associations" do
    it { should belong_to(:user) }
  end
  describe "Validations" do
    it { should belong_to(:user) }
    it { should validate_presence_of(:birthdate) }
    it 'should be major' do
      subject.birthdate = Date.today
      expect(subject).to_not be_valid
    end
    it { should validate_presence_of(:birth_city) }
    it { should validate_presence_of(:phone) }
    it "is not valid without a valid phone" do
      subject.phone = "12345"
      expect(subject).to_not be_valid
    end
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end
end
