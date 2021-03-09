class Address < ApplicationRecord
  attr_accessor :algolia_country_code, :moving_country

  belongs_to :country
  belongs_to :user
  has_many :subscriptions, dependent: :destroy
  accepts_nested_attributes_for :subscriptions
  after_create :set_has_active

  def set_has_active
    Address.where(user: user).each { |address| address.update_columns(active: false) }
    update_columns(active: true)
    Address.where(user: user).each do |address|
      address.destroy unless address.complete? || user.addresses.length == 1 || !address.subscriptions.blank?
    end
  end

  def supported_country?(algolia_country_code)
    !Country.find_by(code: algolia_country_code).nil?
  end

  def complete?
    !city.nil? && !city.blank? && !zipcode.nil? && !zipcode.blank? && !street.nil? && !street.blank?
  end

  def country_name_for_migration
    street.split(',')[-1].strip
  end

  def formatted
    street || I18n.t("country.#{country.code}")
  end
end
