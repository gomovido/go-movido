require 'rails_helper'

RSpec.describe Pickup, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
  end

  describe 'validations' do
    let(:pickup) { build(:pickup) }

    %i[arrival airport state].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it 'saves successfully' do
      expect(pickup.save).to eq(true)
    end
  end
end
