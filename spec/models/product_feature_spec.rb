require 'rails_helper'

RSpec.describe ProductFeature, type: :model do
  let!(:category) { create(:category, :mobile) }
  let!(:company) { create(:company) }
  let!(:category_wifi) { create(:category, :wifi) }
  let!(:country) { create(:country, [:fr, :gb].sample) }
  let!(:mobile) {create(:mobile, :internet_and_call, category: category, company: company, country: country)}
  let!(:wifi) {create(:wifi, category: category_wifi, company: company, country: country)}
  describe 'associations' do
    it { should belong_to(:mobile).optional }
    it { should belong_to(:wifi).optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }

    context 'should validates presence of only one belongs_to association' do
      it 'should not save' do
        subject = build(:product_feature, mobile: mobile, wifi: wifi)
        expect(subject.save).to eq (false)
      end
    end
    context 'should validates presence at least of one belongs_to association' do
      it 'should save' do
        subject = build(:product_feature, mobile: mobile)
        expect(subject.save).to eq (true)
      end
    end
  end
end