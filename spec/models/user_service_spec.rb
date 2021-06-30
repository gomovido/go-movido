require 'rails_helper'

RSpec.describe UserService, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:house) }
    it { is_expected.to belong_to(:service) }
  end
end
