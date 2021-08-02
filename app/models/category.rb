class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_one :service, dependent: :destroy
  belongs_to :pack
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  after_create :set_sku

  def set_sku
    update(sku: name.tr(' ', '_').downcase) if name
  end

  def utilities?
    name == 'utilities'
  end
end
