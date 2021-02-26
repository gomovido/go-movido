require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    it { should have_many(:mobiles) }
    it { should have_many(:wifis) }
    it { should have_many(:banks) }
  end

  describe 'validations' do
    subject { build(:company) }
    it { should allow_value(subject.logo_url).for(:logo_url) }
    it { should_not allow_value('https://facebook.com').for(:logo_url) }
    it { should allow_value(subject.cancel_link).for(:cancel_link) }
    it { should_not allow_value('no-a-valid-link').for(:cancel_link) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:logo_url) }
    it 'should save successfully' do
     expect(subject.save).to eq (true)
    end
  end
end
