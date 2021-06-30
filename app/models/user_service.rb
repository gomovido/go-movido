class UserService < ApplicationRecord
  belongs_to :service
  belongs_to :house
end
