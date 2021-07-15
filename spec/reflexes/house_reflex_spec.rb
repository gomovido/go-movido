require 'rails_helper'

RSpec.describe HouseReflex, type: :reflex do
  let(:user) { create(:user) }
  let(:pack) { create(:pack) }
  let(:country) { create(:country, :fr) }
  let(:company) { create(:company, :mobile) }
  let(:category) { create(:category, :mobile, pack: pack) }
  let!(:product) { create(:product, :mobile, country: country, company: company, category: category) }
  let!(:service) { create(:service, :mobile, category: category) }
  let(:reflex) { build_reflex(url: new_house_url(pack: 'starter'), connection: { current_user: user }, params: { house: { country_id: country.id, pack: 'starter'} }) }

  describe '#create' do
    context 'when record is valid' do
      it 'creates the record' do
        expect(reflex.run(:create)).to morph(".flow-container")
      end
    end

    context 'when record is invalid' do
      it 'throws errors' do
        reflex.params['house']['country_id'] = nil
        reflex.run(:create)
        expect(reflex.get(:house).errors).to be_present
      end

      it 'morphs the form with errors' do
        reflex.params['house']['country_id'] = nil
        subject = reflex.run(:create)
        expect(subject).to morph(".form-base")
      end
    end
  end
end
