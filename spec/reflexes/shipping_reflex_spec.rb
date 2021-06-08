require 'rails_helper'

RSpec.describe ShippingReflex, type: :reflex do
  let(:user) { create(:user) }
  let!(:country) { create(:country, :fr) }
  let(:company) { create(:company, :mobile) }
  let(:category) { create(:category, :mobile) }
  let(:user_preference) { create(:user_preference, user: user, country: country) }
  let(:cart) { create(:cart, user_preference: user_preference) }
  let!(:order) { create(:order, user: user, state: 'pending_payment') }
  let!(:product) { create(:product, :mobile, country: country, company: company, category: category) }
  let!(:item) { create(:item, product: product, cart: cart, order: order) }
  let(:reflex) { build_reflex(url: conversion_url(order), connection: { current_user: user }, params: { shipping: { address: "38 Rue Cler, 75007 Paris, France", instructions: "Call me before" } }) }

  describe '#create' do
    context 'when no shipping already associated' do
      it 'creates a shipping associated to the right order' do
        reflex.run(:create)
        order.reload
        expect(order.shipping).to be_present
      end

      it 'morphs to the next step' do
        expect(reflex.run(:create)).to morph(".flow-container")
      end
    end

    context 'when a shipping is already associated' do
      let!(:shipping) { create(:shipping, address: 'bla bla bla', instructions: 'blablabla') }

      it 'updates the shipping record' do
        order.update(shipping: shipping)
        reflex.run(:create)
        order.reload
        expect(order.shipping.address).to eq("38 Rue Cler, 75007 Paris, France")
      end

      it 'morphs to the next step' do
        expect(reflex.run(:create)).to morph(".flow-container")
      end
    end

    context 'shipping is invalid' do
      it 'morphs the same page' do
        reflex.params['shipping']['address'] = nil
        expect(reflex.run(:create)).to morph(".form-base")
      end
    end
  end
end