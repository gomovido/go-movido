class Plan < ApplicationRecord
  belongs_to :subscription
  belongs_to :product
  validates :state, :name, presence: true
  validates :state, inclusion: { in: ["cancelled", "pending_payment", "active"] }
  after_save :update_subscription_plan

  def update_subscription_plan
    StripeApiBillingService.new(subscription_id: subscription.id, plan_id: self.id).update_subscription_plan if state == 'cancelled'
  end

end
