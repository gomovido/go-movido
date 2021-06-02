class LeadReflex < ApplicationReflex
  delegate :uuid, to: :connection

  before_reflex do
    @lead = Lead.new(campaign_type: 'simplicity_stressful')
    @lead.assign_attributes(lead_params)

    throw :abort unless @lead.valid?
  end

  def submit
    @lead.save
  end

  private

  def lead_params
    params.require(:lead).permit(:email)
  end
end
