class Person < ApplicationRecord
  belongs_to :user
  validates_presence_of :birthdate, :birth_city, :phone
  phony_normalize :phone, default_country_code: I18n.locale.to_s.upcase
  validates_plausible_phone :phone, presence: true
  validate :validate_age

  private

  def validate_age
    errors.add(:birthdate, I18n.t('people.form.failure.min_age')) if birthdate.present? && birthdate > 18.years.ago.to_date
  end
end
