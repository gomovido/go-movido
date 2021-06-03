require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    %i[user charge billing shipping].each do |field|
      it { is_expected.to belong_to(field) }
    end

    it { is_expected.to have_one(:pickup) }

  end

  describe 'validations' do
    let(:order) { build(:order) }

    it { is_expected.to validate_presence_of(:state) }


    it 'saves successfully' do
      expect(order.save).to eq(true)
    end
  end
end
