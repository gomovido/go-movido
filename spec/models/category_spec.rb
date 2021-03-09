require 'rails_helper'

RSpec.describe Category do
  describe "Associations" do
    it { is_expected.to have_many(:mobiles) }
    it { is_expected.to have_many(:wifis) }
    it { is_expected.to have_many(:banks) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:sku) }
    it { is_expected.to validate_presence_of(:form_timer) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:subtitle) }
  end
end
