class Wifi < ApplicationRecord
  belongs_to :category
  belongs_to :company
  belongs_to :country
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy
  has_many :special_offers, dependent: :destroy
  validates_presence_of :name, :area, :price, :time_contract, :setup_price, :data_speed
  validates_inclusion_of :active, in: [true, false]
end
