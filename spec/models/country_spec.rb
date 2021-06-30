require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:houses) }
    it { is_expected.to have_many(:products) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
  end

  describe 'model methods' do
    let(:country) { create(:country, :fr) }

    it 'has the right currency' do
      expect(country.currency).to eq('EUR')
    end
  end
end
