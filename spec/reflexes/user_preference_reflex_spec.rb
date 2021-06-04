require 'rails_helper'

RSpec.describe UserPreferenceReflex, type: :reflex do
  let(:user) { create(:user)}
  let(:country) { create(:country, :fr)}
  let(:reflex) { build_reflex(url: simplicity_url, connection: { current_user: user }, params: { user_preference: { arrival: Faker::Date.forward(days: 30), stay_duration: 12, country_id: country.id} }) }


  describe 'when record is valid' do

    context '#create' do
      it 'should create the record' do
        expect(reflex.run(:associate_country)).to eq(true)
      end
    end
  end

  describe 'when record is invalid' do

    context '#create' do
      it 'should trow errors' do
        reflex.params['user_preference']['country_id'] = nil
        reflex.run(:associate_country)
        expect(reflex.get(:user_pref).errors).to be_present
      end
    end
  end

end
