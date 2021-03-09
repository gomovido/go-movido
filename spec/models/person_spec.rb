require 'rails_helper'

RSpec.describe Person do
  subject(:person) { create(:person, country.code.to_sym, user: user) }

  let(:user) { create(:user) }
  let!(:country) { create(:country, %i[fr gb].sample) }

  describe "Associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:birthdate) }

    it 'is expected to validate that :birthdate is at least 18 years ago' do
      person.birthdate = Time.zone.today
      expect(person).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:birth_city) }
    it { is_expected.to validate_presence_of(:phone) }

    it "is not valid without a valid phone" do
      person.phone = "12345"
      expect(person).not_to be_valid
    end

    it "is valid with valid attributes" do
      expect(person).to be_valid
    end
  end
end
