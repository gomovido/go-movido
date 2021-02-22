require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'associations' do
    it { should have_many(:addresses) }
    it { should have_many(:users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:code) }
  end
end
