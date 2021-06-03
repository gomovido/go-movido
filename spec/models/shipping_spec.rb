require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:order) }
  end

  describe 'validations' do
    let(:shipping) { build(:shipping) }

    %i[address state tracking_id delivery_date].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it { is_expected.not_to allow_value("wrong_state").for(:state) }
    it { is_expected.to allow_value("delivering").for(:state) }

    it 'saves successfully' do
      expect(shipping.save).to eq(true)
    end
  end
end
