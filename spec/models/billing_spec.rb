require 'rails_helper'

RSpec.describe Billing, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  describe 'validations' do
    let(:billing) { build(:billing) }

    it { is_expected.to validate_presence_of(:address) }


    it 'saves successfully' do
      expect(billing.save).to eq(true)
    end
  end
end
