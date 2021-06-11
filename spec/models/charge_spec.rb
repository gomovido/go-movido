require 'rails_helper'

RSpec.describe Charge, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:order) }
  end

  describe 'validations' do
    let(:charge) { build(:charge) }

    it { is_expected.to validate_presence_of(:state) }

    it 'saves successfully' do
      expect(charge.save).to eq(true)
    end
  end
end
