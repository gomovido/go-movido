class Coupon < ApplicationRecord
  has_and_belongs_to_many :mobiles, -> { distinct }
  validates :mobiles_products_list, presence: true
  before_create :create_mobiles_associations
  after_create :create_stripe_coupon
  validates :name, presence: true
  validates :duration, inclusion: { in: ['forever', 'repeating'] }
  validates :duration_in_months, presence: { unless: :duration_is_forever? }
  validates :percent_off, presence: { if: :campaign_is_discount? }
  validates :livemode, inclusion: { in: [true, false] }
  validates :campaign_type, inclusion: { in: ['voucher', 'discount'] }

  def create_mobiles_associations
    mobiles_products_list.each do |mobile|
      mobile = Mobile.find_by(full_name: mobile)
      mobiles << mobile if mobile
    end
  end

  def duration_is_forever?
    duration == 'forever'
  end

  def campaign_is_discount?
    campaign_type == 'discount'
  end

  def create_stripe_coupon
    if stripe_id.nil? && campaign_type == 'discount'
      response = StripeApiCouponService.new(coupon_id: id).create
      update(stripe_id: response[:coupon_id]) if response[:coupon_id]
    end
  end

end
