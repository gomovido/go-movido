require 'rails_helper'

RSpec.describe Pack, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:categories) }
  end

  describe 'validations' do
    let(:pack) { build(:pack) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.not_to allow_value("wrong_name").for(:name) }
    it { is_expected.to allow_value("settle_in").for(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    it 'saves successfully' do
      expect(pack.save).to eq(true)
    end
  end
end
