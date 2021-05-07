class Subscription < ApplicationRecord
  attr_accessor :algolia_country_code

  belongs_to :address
  belongs_to :product, polymorphic: true
  belongs_to :coupon, optional: true
  has_one :billing, dependent: :destroy
  accepts_nested_attributes_for :address
  validates :delivery_address, presence: true, on: :update
  validate :delivery_address_country, on: :update, if: :delivery_address?
  validates_plausible_phone :contact_phone, presence: true, on: :update, if: :product_is_wifi?
  validate :contact_phone_country, on: :update, if: :product_is_wifi?
  after_create :create_on_stripe

  def create_on_stripe
    response = StripeApiOrderService.new(user_id: address.user.id, subscription_id: id).init_order
    update_columns(stripe_id: response[:stripe_order].id) if response[:stripe_order]
  end

  def product_is_wifi?
    product_type == 'Wifi'
  end

  def random_password
    special_chars = ('!'..'?').to_a
    special_chars.delete('"')
    random_char = (special_chars - (0..9).to_a.map(&:to_s)).sample
    chars = ((0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a)
    chars.sort_by { rand }.first(12).push(random_char).shuffle.join
  end

  def product_is_mobile?
    product_type == 'Mobile'
  end

  def product_is_uk?
    product.country.code == 'gb'
  end

  def path_to_first_step
    if product_is_wifi?
      Rails.application.routes.url_helpers.edit_subscription_address_path(self, address, locale: I18n.locale)
    elsif product_is_mobile?
      Rails.application.routes.url_helpers.new_subscription_billing_path(self, locale: I18n.locale)
    end
  end

  def slack_notification
    return unless Rails.env.production?

    slack_notification = "
    💸 Boom! New subscription purchased 💸\n
    Product : #{product.name}\n
    User's email : #{address.user.email}. \n
    Price : #{product.format_price}\n
    Company : #{product.company.name}\n
    [Forest Admin link](https://app.forestadmin.com/go-movido-admin/#{Rails.env.capitalize}/Movido/data/Subscription/index/record/Subscription/#{id}/details)"
    SlackNotifier::CLIENT.ping slack_notification
  end

  def delivery_address_country
    if product_is_wifi? && algolia_country_code != address.country.code
      errors.add(:delivery_address,
                 I18n.t('addresses.edit.form.failure.wrong_country', country: I18n.t("country.#{product.country.code}")))
    elsif product.company.name.casecmp("giffgaff").zero? && delivery_address.split(',').length < 2
      errors.add(:delivery_address, I18n.t('addresses.edit.form.failure.invalid'))
    end
  end

  def icon_state
    case state
    when 'draft'
      'far fa-clipboard-list'
    when 'succeeded'
      "fas fa-spinner"
    when 'activated'
      "fas fa-check-circle"
    when 'failed'
      "fas fa-times-circle"
    else
      "fab fa-cc-visa"
    end
  end

  def format_amount
    price = amount.to_f / 100
    format_price = (price % 1).zero? ? price.to_i.to_s : '%.2f' % price
    product.country.currency == 'GBP' ? "#{product.country.currency_sign}#{format_price}" : "#{format_price}#{product.country.currency_sign}"
  end

  def contact_phone_country
    country_code_number = IsoCountryCodes.find(product.country.code).calling
    errors.add(:contact_phone, I18n.t('addresses.edit.form.failure.wrong_country', country: I18n.t("country.#{product.country.code}"))) unless contact_phone.start_with?(country_code_number)
  end

  # rubocop:disable Metrics/PerceivedComplexity
  def current_step(controller_name)
    if product_is_wifi?
      case controller_name
      when 'addresses'
        2
      when 'billings'
        3
      else
        4
      end
    elsif product_is_mobile? && product.payment?
      case controller_name
      when 'billings'
        2
      when 'subscriptions'
        3
      else
        4
      end
    elsif product_is_mobile? && !product.payment?
      controller_name == 'billings' ? 2 : 3
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity
end
