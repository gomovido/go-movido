require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  describe 'validations' do
    let(:shipping) { build(:shipping) }

    %i[address state tracking_id delivery_date].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it 'saves successfully' do
      expect(shipping.save).to eq(true)
    end
  end
end
