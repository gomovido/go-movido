class SpecialOffer < ApplicationRecord
  validate :association_is_valid?
  belongs_to :mobile, optional: true
  belongs_to :wifi, optional: true
  validates :mobile_id, presence: { unless: :wifi_id? }
  validates :wifi_id, presence: { unless: :mobile_id? }
  translates :name, fallbacks_for_empty_translations: true, touch: true
  after_touch :destroy_no_translations
  accepts_nested_attributes_for :translations, allow_destroy: true

  validates_associated :translations
  translation_class.validates_presence_of :name

  def association_is_valid?
    errors.add(:error, "Already associated") if mobile_id && wifi_id
  end

  def destroy_no_translations
    destroy if translations.blank?
  end
end
