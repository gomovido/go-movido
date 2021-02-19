class Billing < ApplicationRecord
  belongs_to :subscription
  belongs_to :user
  validates_presence_of :iban, :address, :bank, :holder_name
  validates_presence_of :bic, unless: :product_is_uk?
  validates_presence_of :account_number, :sort_code, if: :product_is_uk?
  validate :billing_address_country
  validate :check_iban
  accepts_nested_attributes_for :subscription

  def product_is_uk?
    self.subscription.product.country == 'gb'
  end

  def iban_prettify
    IBANTools::IBAN.new(self.iban).prettify
  end

  def check_iban
    if self.iban.blank?
      return self.errors.add(:iban, :blank)
    else
      response = JSON.parse(IbanApiService.new(iban: self.iban).api_call)
      response["validations"].each do |validation, details|
        self.errors.add(:iban, I18n.t("iban.errors.error_#{details["code"]}")) if details["code"].to_i < 208 && details["code"].to_i > 200
      end
      self.errors.add(:iban, I18n.t('billings.new.form.failure.wrong_country', country: t("country.#{self.subscription.product.country.code}"))) if !response["bank_data"]["country_iso"].nil? && response["bank_data"]["country_iso"].downcase != self.subscription.product.country.code
      self.bic = response["bank_data"]["bic"]
      self.bank = response["bank_data"]["bank"]
      self.account_number = response["bank_data"]["account"]
      self.sort_code = response["bank_data"]["branch_code"]
    end
  end

  def billing_address_country
    self.errors.add(:address, I18n.t('billings.new.form.failure.wrong_country', country: t("country.#{self.subscription.product.country.code}"))) unless !self.address.blank? && self.address.split(',')[-1].strip == self.subscription.product.country.name
  end
end
