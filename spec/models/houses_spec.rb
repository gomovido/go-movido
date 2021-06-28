require 'rails_helper'

RSpec.describe House, type: :model do
  subject(:house) { build(:house) }

  describe 'associations' do
    it { is_expected.to have_many(:carts) }
    it { is_expected.to have_one(:house_detail) }
    it { is_expected.to have_many(:services) }
    it { is_expected.to belong_to(:country) }
    it { is_expected.to belong_to(:user) }
  end
end
