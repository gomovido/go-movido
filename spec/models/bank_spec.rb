require 'rails_helper'

RSpec.describe Bank, type: :model do
  describe 'associations' do
    it { should belong_to(:company).optional }
  end
  describe 'validations' do
    it { should allow_value("https://transferwise.com").for(:affiliate_link) }
    it { should_not allow_value("zzgz").for(:affiliate_link) }
    [:headline, :feature_1, :feature_2, :feature_3, :feature_4].each do |field|
      it { should validate_presence_of(field) }
    end
  end
end
