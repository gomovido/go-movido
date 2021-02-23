class ProductFeature < ApplicationRecord
  validate :association_is_valid?
  belongs_to :product
  belongs_to :mobile, optional: true
  belongs_to :wifi, optional: true
  validates_presence_of :mobile_id, unless: :wifi_id?
  validates_presence_of :wifi_id, unless: :mobile_id?

  def association_is_valid?
    errors.add(:error, "Already associated") if (mobile_id and wifi_id)
  end
end
