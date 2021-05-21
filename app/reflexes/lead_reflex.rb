class LeadReflex < ApplicationReflex
  def submit
    @lead = Lead.new(campaign_type: 'simplicity_stressful')
    @lead.assign_attributes(lead_params)
    @lead.save!
  end

  private

  def lead_params
    params.require(:lead).permit(:email)
  end
end
