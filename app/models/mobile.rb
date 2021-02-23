class Mobile < ApplicationRecord
  belongs_to :category
  belongs_to :company
  belongs_to :country
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy
  has_many :special_offers, dependent: :destroy
  validates :data_unit, inclusion: { in: ["GB", "MB"] }, unless: :unlimited_data?
  validates :offer_type, inclusion: { in: ["call_only", "internet_only", "internet_and_call"] }
  validates_presence_of :name, :area, :price, :offer_type, :time_contract, :sim_card_price
  validates_inclusion_of :sim_needed, in: [true, false]
  validates_inclusion_of :active, in: [true, false]
  validates_presence_of :data, if: :internet_only?
  validates_presence_of :call, if: :call_only?
  validates_presence_of :call, :data, if: :internet_and_call?


  def internet_only?
    offer_type == 'internet_only'
  end

  def call_only?
    offer_type == 'call_only'
  end

  def internet_and_call?
    offer_type == 'internet_and_call'
  end

  def unlimited_data?
    data.nil? or data.zero?
  end

end
