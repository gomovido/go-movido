module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    identified_by :uuid

    def connect
      self.current_user = env["warden"].user(:user)
      self.uuid = SecureRandom.urlsafe_base64
      reject_unauthorized_connection unless current_user || uuid
    end
  end
end
