class LeadReflex < ApplicationReflex
  def submit
    @lead = Lead.new(campaign_type: 'simplicity_stressful')
    @lead.assign_attributes(lead_params)
    if @lead.save
      flash[:notice] = "We'll get in touch with you very soon"
    else
      flash[:alert] = "This email is invalid"
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:email)
  end
end
