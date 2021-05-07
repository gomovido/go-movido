class Coupon < ApplicationRecord
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :mobiles, -> { distinct }
  has_and_belongs_to_many :wifis, -> { distinct }
  # rubocop:enable Rails/HasAndBelongsToMany
  before_create :create_mobiles_associations, :create_wifis_associations
  after_create :create_stripe_coupon
  has_many :subscriptions, dependent: :nullify
  validates :name, presence: true
  validates :percent_off, presence: { if: :campaign_is_discount? }
  validates :livemode, inclusion: { in: [true, false] }
  validates :campaign_type, inclusion: { in: ['voucher', 'discount'] }
  validate :associations
  after_update :update_stripe_coupon

  def update_stripe_coupon
    StripeApiCouponService.new(coupon_id: id).update if campaign_is_discount?
  end

  def associations
    if campaign_is_voucher? && (wifis_products_list.blank? && mobiles_products_list.blank?)
      errors.add(:campaign_type, 'You need at least one product to create a voucher')
    elsif campaign_is_discount? && (mobiles_products_list.blank? || wifis_products_list.present?)
      errors.add(:campaign_type, 'You need at least one mobile to create a discount')
    end
  end

  def create_wifis_associations
    wifis_products_list.each do |wifi|
      wifi = Wifi.find_by(full_name: wifi)
      wifis << wifi if wifi
    end
  end

  def create_mobiles_associations
    mobiles_products_list.each do |mobile|
      mobile = Mobile.find_by(full_name: mobile)
      mobiles << mobile if mobile
    end
  end

  def campaign_is_discount?
    campaign_type == 'discount'
  end

  def campaign_is_voucher?
    campaign_type == 'voucher'
  end

  def create_stripe_coupon
    return unless stripe_id.nil? && campaign_is_discount?

    response = StripeApiCouponService.new(coupon_id: id).create
    update(stripe_id: response[:coupon_id]) if response[:coupon_id]
  end

  def products
    mobiles + wifis
  end
end
