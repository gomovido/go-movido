require 'rails_helper'

RSpec.describe UserPreferenceReflex, type: :reflex do
  let(:user) { create(:user) }
  let(:country) { create(:country, :fr) }
  let(:reflex) { build_reflex(url: simplicity_url, connection: { current_user: user }, params: { user_preference: { arrival: Faker::Date.forward(days: 30), stay_duration: 12, country_id: country.id } }) }

  describe '#create' do
    context 'when record is valid' do
      it 'creates the record' do
        expect(reflex.run(:create)).to eq(true)
      end
    end

    context 'when record is invalid' do
      it 'trhows errors' do
        reflex.params['user_preference']['country_id'] = nil
        reflex.run(:create)
        expect(reflex.get(:user_pref).errors).to be_present
      end
    end
  end
end
