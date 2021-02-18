class Person < ApplicationRecord
  belongs_to :user
  validates_presence_of :birthdate, :birth_city, :phone
  phony_normalize :phone, default_country_code: 'FR'
  validates_plausible_phone :phone, presence: true
  validate :validate_age

  private

  def validate_age
    if self.birthdate.present? && self.birthdate > 18.years.ago.to_date
        self.errors.add(:birthdate, I18n.t('people.form.failure.min_age'))
    end
  end
end
