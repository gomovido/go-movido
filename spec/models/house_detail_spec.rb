require 'rails_helper'

RSpec.describe HouseDetail, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:house) }
  end

  describe 'validations' do
    let(:house_detail) { build(:house_detail) }

    %i[description name activation_price subscription_price image_url].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it 'saves successfully' do
      expect(company.save).to eq(true)
    end
  end
end
