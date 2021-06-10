# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  # Put application wide Reflex behavior in this file.
  #
  # Example:
  #
  #   # If your ActionCable connection is: `identified_by :current_user`
  #   delegate :current_user, to: :connection
  #
  # Learn more at: https://docs.stimulusreflex.com
  def with_locale(&block)
    I18n.with_locale(session[:locale], &block)
  end

  def morph_if_paid(order_id)
    order = Order.find(order_id)
    morph '.flow-container', render(partial: "steps/order/congratulations", locals: { order: order, messages: [{ content: "Congratulations #{current_user.first_name} Your movido Starter Pack is already on its way to you", delay: 0 }] }) if order.paid?
  end
end
