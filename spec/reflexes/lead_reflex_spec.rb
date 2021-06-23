require 'rails_helper'

RSpec.describe LeadReflex, type: :reflex do
  let(:user) { create(:user) }
  let(:reflex) { build_reflex(url: root_url, connection: { current_user: user }) }

  describe '#create' do
    it 'create a lead' do
      reflex.run(:submit)
      expect(Lead.find_by(email: user.email)).to eq(reflex.get(:lead))
    end
  end
end
