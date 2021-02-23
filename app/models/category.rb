class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :mobiles, dependent: :destroy
  has_many :wifis, dependent: :destroy

  CATEGORIES = %w[wifi mobile bank gym transportation housing utilities community]
  extend FriendlyId
  friendly_id :sku, use: :slugged


  validates :name, presence: true, inclusion: { in: CATEGORIES }
  validates :sku, :form_timer, :description, :subtitle, presence: true


end
