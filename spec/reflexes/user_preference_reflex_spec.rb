require 'rails_helper'

RSpec.describe UserPreferenceReflex, type: :reflex do
  let(:user) { create(:user) }
  let(:reflex) { build_reflex(url: user_preferences_url, connection: { current_user: user }, params: { user_preference: { arrival: Faker::Date.forward(days: 30), stay_duration: 12} }) }

  describe '#create' do
    subject { reflex.run(:associate_country) }

    it 'creates a user preference associated to the country and the current user' do

      expect(reflex.get(:user_preference)).to be_present
    end
  end
end
