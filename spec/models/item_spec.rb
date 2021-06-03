require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    %i[cart product charge order].each do |field|
      it { is_expected.to belong_to(field) }
    end
  end
end
