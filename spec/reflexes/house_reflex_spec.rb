require 'rails_helper'

RSpec.describe HouseReflex, type: :reflex do
  let(:user) { create(:user) }
  let(:country) { create(:country, :fr) }
  let(:reflex) { build_reflex(url: new_house_url, connection: { current_user: user }, params: { house: { country_id: country.id } }) }

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
