class Mobile < ApplicationRecord
  belongs_to :category
  belongs_to :company
  belongs_to :country
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy
  has_many :special_offers, dependent: :destroy
  validates :data_unit, inclusion: { in: ["GB", "MB"] }
  validates :offer_type, inclusion: { in: ["call_only", "internet_only", "internet_and_call"] }
  validates_presence_of :name, :area, :price, :offer_type, :time_contract, :sim_card_price,
      :active, :sim_needed
  validates_presence_of :data, :data_unit, if: :internet_only?
  validates_presence_of :call, if: :call_only?
  validates_presence_of :call, :data, :data_unit, if: :internet_and_call?


  def internet_only?
    offer_type == 'internet_only'
  end

  def call_only?
    offer_type == 'call_only'
  end

  def internet_and_call?
    offer_type == 'internet_and_call'
  end

end
