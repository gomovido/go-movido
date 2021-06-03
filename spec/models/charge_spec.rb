require 'rails_helper'

RSpec.describe Charge, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  describe 'validations' do
    let(:charge) { build(:charge) }

    %i[stripe_charge_id state ].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end


    it 'saves successfully' do
      expect(charge.save).to eq(true)
    end
  end
end
