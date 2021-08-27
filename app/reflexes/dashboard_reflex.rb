class DashboardReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def subscriptions(arg)
  end
end
