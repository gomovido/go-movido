require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'associations' do
    it { should have_one(:billing) }
    it { should have_one(:charge) }
    it { is_expected.to have_db_column(:product_id).of_type(:integer) }
    it { is_expected.to have_db_column(:product_type).of_type(:string) }
    it { is_expected.to belong_to(:product) }
  end
end
