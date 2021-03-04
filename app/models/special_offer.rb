class SpecialOffer < ApplicationRecord
  validate :association_is_valid?
  belongs_to :mobile, optional: true
  belongs_to :wifi, optional: true
  validates_presence_of :mobile_id, unless: :wifi_id?
  validates_presence_of :wifi_id, unless: :mobile_id?
  translates :name, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations, allow_destroy: true
  validates_associated :translations
  translation_class.validates_presence_of :name

  def association_is_valid?
    errors.add(:error, "Already associated") if (mobile_id and wifi_id)
  end
end
