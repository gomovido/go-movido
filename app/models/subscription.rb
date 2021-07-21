class Subscription < ApplicationRecord
  belongs_to :movido_subscription, optional: true
  belongs_to :order
  attr_accessor :terms, :terms_provider
end
