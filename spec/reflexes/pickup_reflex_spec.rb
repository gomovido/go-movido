require 'rails_helper'

RSpec.describe PickupReflex, type: :reflex do
  let(:user) { create(:user) }
  let!(:country) { create(:country, :fr) }
  let(:company) { create(:company, :mobile) }
  let(:category) { create(:category, :mobile) }
  let(:user_preference) { create(:user_preference, user: user, country: country) }
  let(:cart) { create(:cart, user_preference: user_preference) }
  let!(:order) { create(:order, user: user, state: 'pending_payment') }
  let!(:product) { create(:product, :mobile, country: country, company: company, category: category) }
  let!(:item) { create(:item, product: product, cart: cart, order: order) }
  let(:reflex) { build_reflex(url: conversion_url(order), connection: { current_user: user }, params: { pickup: { uncomplete: false, arrival: Faker::Date.forward(days: 30), flight_number: 'XXX1234', airport: "Paris CDG" } }) }

  describe '#create' do
    context 'when infos are complete and record is valid' do
      it 'creates a pickup' do
        expect(reflex.run(:create)).to morph(".flow-container")
      end
    end

    context 'when infos are complete and record is invvalid' do
      it 'creates a pickup' do
        reflex.params['pickup']['arrival'] = nil
        expect(reflex.run(:create)).to morph(".form-base")
      end
    end

    context 'when infos are uncomplete' do
      it 'creates a pickup with empty values' do
        reflex.params['pickup']['uncomplete'] = true
        reflex.run(:create)
        expect(reflex.get(:pickup).flight_number).to be_nil
      end
    end
  end
end
