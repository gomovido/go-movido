require 'rails_helper'

RSpec.describe CartReflex, type: :reflex do
  let(:user) {create(:user)}
  let(:country) {create(:country, :fr)}
  let(:company) { create(:company, :mobile) }
  let(:category) { create(:category, :mobile) }
  let(:product) { create(:product, :mobile, country: country, company: company, category: category) }
  let!(:user_preference) {create(:user_preference, user: user, country: country)}
  let!(:service) {create(:service, :mobile)}
  let!(:user_service) {create(:user_service, user_preference: user_preference, service: service)}
  let(:reflex) { build_reflex(url: simplicity_url(host: 'localhost', port: 3000), connection: { current_user: user })}


  describe '#create' do
    it 'create a cart with items' do
      expect(reflex.run(:create)).to eq(true)
    end
  end

  describe '#init items' do
    it 'create a items and add it to the cart' do
      reflex.run(:init_items)
      expect(user.user_preference.cart.items.count).to eq(1)
    end
  end
end
