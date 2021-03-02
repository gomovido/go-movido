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
    I18n.with_locale(session[:locale]) { yield }
  end
end
