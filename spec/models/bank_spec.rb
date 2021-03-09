require 'rails_helper'

RSpec.describe Bank, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
    it { should belong_to(:category) }
  end
  describe 'validations' do
    %i[headline feature_1 feature_2 feature_3 feature_4].each do |field|
      it { should validate_presence_of(field) }
    end
  end
end
