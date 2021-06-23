class LeadReflex < ApplicationReflex
  delegate :current_user, to: :connection

  before_reflex do
    @lead = Lead.new(email: current_user.email, campaign_type: 'pre_register_settle_in')

    throw :abort unless @lead.valid?
  end

  def submit
    @lead.save
    morph :nothing
  end
end
