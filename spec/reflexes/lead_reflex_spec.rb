require 'rails_helper'

RSpec.describe LeadReflex, type: :reflex do
  let(:reflex) { build_reflex(url: root_url, params: { lead: { email: 'user@test.now' } }) }

  describe '#create' do
    it 'create a lead' do
      expect(reflex.run(:submit)).to eq(true)
    end
  end
end
