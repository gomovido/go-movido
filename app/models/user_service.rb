class UserService < ApplicationRecord
  belongs_to :service
  belongs_to :user_preference
end