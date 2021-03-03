require 'rails_helper'

RSpec.describe Category do
  describe "Associations" do
    it { should have_many(:mobiles) }
    it { should have_many(:wifis) }
    it { should have_many(:banks) }
  end
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:sku) }
    it { should validate_presence_of(:form_timer) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:subtitle) }
  end
end
