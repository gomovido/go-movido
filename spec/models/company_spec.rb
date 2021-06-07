require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:products) }
  end

  describe 'validations' do
    let(:company) { build(:company, :mobile) }

    it { is_expected.to allow_value(company.logo_url).for(:logo_url) }
    it { is_expected.not_to allow_value('https://facebook.com').for(:logo_url) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:logo_url) }

    it 'saves successfully' do
      expect(company.save).to eq(true)
    end
  end
end
