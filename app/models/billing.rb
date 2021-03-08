class Billing < ApplicationRecord
  attr_accessor :algolia_country_code

  belongs_to :subscription
  belongs_to :user
  validates_presence_of :iban, :address, :bank, :holder_name
  validates_presence_of :bic, unless: :product_is_uk?
  validates_presence_of :account_number, :sort_code, if: :product_is_uk?
  validate :billing_address_country
  validate :check_iban, if: :product_is_fr?
  validate :calculate_iban, if: :product_is_uk?
  accepts_nested_attributes_for :subscription

  def product_is_uk?
    subscription.product.country.code == "gb"
  end

  def product_is_fr?
    subscription.product.country.code == "fr"
  end

  def iban_prettify
    IBANTools::IBAN.new(iban).prettify
  end

  def calculate_iban
    return errors.add(:sort_code, :blank) if sort_code.blank?
    return errors.add(:account_number, :blank) if account_number.blank?

    response = JSON.parse(IbanApiService.new(sort_code: sort_code, account_number: account_number).calculate_iban)
    if response['error'].blank?
      self.bank = response["bank"]
      self.iban = response["iban"]
    else
      response['error'][0].casecmp('s').zero? ? errors.add(:sort_code, :invalid) : errors.add(:account_number, :invalid)
    end
  end

  def check_iban
    return errors.add(:iban, :blank) if iban.blank?

    response = JSON.parse(IbanApiService.new(iban: iban).check_iban)
    response["validations"].each do |_validation, details|
      errors.add(:iban, I18n.t("iban.errors.error_#{details['code']}")) if details["code"].to_i < 208 && details["code"].to_i > 200
    end
    if !response["bank_data"]["country_iso"].nil? && response["bank_data"]["country_iso"].downcase != subscription.product.country.code
      errors.add(:iban,
                 I18n.t('billings.new.form.failure.wrong_country',
                        country: I18n.t("country.#{subscription.product.country.code}")))
    end
    self.bic = response["bank_data"]["bic"]
    self.bank = response["bank_data"]["bank"]
    self.account_number = response["bank_data"]["account"]
    self.sort_code = response["bank_data"]["branch_code"]
  end

  def billing_address_country
    return if !address.blank? && algolia_country_code == subscription.product.country.code

    errors.add(:address, I18n.t('billings.new.form.failure.wrong_country', country: I18n.t("country.#{subscription.product.country.code}")))
  end
end
