class ProductFeature < ApplicationRecord
  validate :association_is_valid?
  belongs_to :mobile, optional: true
  belongs_to :wifi, optional: true
  validates_presence_of :mobile_id, unless: :wifi_id?
  validates_presence_of :wifi_id, unless: :mobile_id?
  translates :name, :description, fallbacks_for_empty_translations: true, touch: true
  after_touch :destroy_no_translations
  accepts_nested_attributes_for :translations, :allow_destroy => true

  validates_associated :translations
  translation_class.validates_presence_of :name, :description

  def association_is_valid?
    errors.add(:error, "Already associated") if (mobile_id and wifi_id)
  end

  def destroy_no_translations
    self.destroy if self.translations.blank?
  end

end
