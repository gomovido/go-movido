class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  after_create :set_sku

  def set_sku
    update(sku: name.tr(' ', '_').downcase) if name
  end
end
