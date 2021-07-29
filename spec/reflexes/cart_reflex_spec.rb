require 'rails_helper'

RSpec.describe CartReflex, type: :reflex do
  let(:user) { create(:user) }
  let(:pack) { create(:pack) }
  let(:country) { create(:country, :fr) }
  let(:company) { create(:company, :mobile) }
  let(:category) { create(:category, :mobile, pack: pack) }
  let!(:product) { create(:product, :mobile, country: country, company: company, category: category) }
  let!(:service) { create(:service, :mobile, category: category) }
  let!(:house) { create(:house, user: user, country: country) }

  describe 'initializing cart' do
    let(:reflex) { build_reflex(url: new_cart_url(pack: 'starter'), connection: { current_user: user }, params: { pack: 'starter', house: { terms: '1' }, order: { affiliate_link: '' } }) }

    it 'creates a cart' do
      reflex.run(:initialize_order)
      reflex.run(:initialize_cart)
      expect(user.house.carts.last).to be_present
    end
  end

  describe '#init items' do
    context 'with items' do
      let(:reflex) { build_reflex(url: new_cart_url(pack: 'starter'), connection: { current_user: user }, params: { house: { service_ids: [service.id], terms: '1', pack: 'starter' }, order: { affiliate_link: '' } }) }

      it 'create user services' do
        reflex.run(:init_user_services)
        expect(user.house.user_services.count).to eq(1)
      end

      it 'create items' do
        reflex.run(:create)
        expect(user.house.carts.last.items.count).to eq(1)
      end
    end

    context 'without items' do
      let(:reflex) { build_reflex(url: new_cart_url(pack: 'starter'), connection: { current_user: user }, params: { house: { terms: '1', pack: 'starter'}, order: { affiliate_link: '' } }) }

      it 'sticks on the same page if no service is checked' do
        expect(reflex.run(:create)).to morph(".form-base")
      end
    end
  end
end
