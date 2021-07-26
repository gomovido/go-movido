class Subscription < ApplicationRecord
  belongs_to :order
  attr_accessor :terms, :terms_provider
end
