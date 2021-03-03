require 'rails_helper'

RSpec.describe Bank, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
  end
  describe 'validations' do
    [:headline, :feature_1, :feature_2, :feature_3, :feature_4, :affiliate_link].each do |field|
      it { should validate_presence_of(field) }
    end
  end
end
