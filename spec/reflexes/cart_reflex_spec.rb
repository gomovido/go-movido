require 'rails_helper'

RSpec.describe CartReflex, type: :reflex do
  let(:user) { create(:user) }
  let(:country) { create(:country, :fr) }
  let(:company) { create(:company, :mobile) }
  let(:category) { create(:category, :mobile) }
  let!(:product) { create(:product, :mobile, country: country, company: company, category: category) }
  let!(:service) { create(:service, :mobile, category: category) }
  let!(:user_preference) { create(:user_preference, user: user, country: country) }

  describe 'initializing cart' do
    let(:reflex) { build_reflex(url: new_cart_url, connection: { current_user: user }) }

    it 'creates a cart' do
      reflex.run(:initialize_order)
      reflex.run(:initialize_cart)
      expect(user.user_preference.carts.last).to be_present
    end
  end

  describe '#init items' do
    context 'with items' do
      let(:reflex) { build_reflex(url: new_cart_url, connection: { current_user: user }, params: { user_preference: { service_ids: [service.id] } }) }

      it 'create user services' do
        reflex.run(:init_user_services)
        expect(user.user_preference.user_services.count).to eq(1)
      end

      it 'create items' do
        reflex.run(:create)
        expect(user.user_preference.carts.last.items.count).to eq(1)
      end
    end

    context 'without items' do
      let(:reflex) { build_reflex(url: new_cart_url, connection: { current_user: user }) }

      it 'sticks on the same page if no service is checked' do
        expect(reflex.run(:create)).to morph(".form-base")
      end
    end
  end
end
