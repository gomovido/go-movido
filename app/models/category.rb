class Category < ApplicationRecord
  has_many :mobiles, dependent: :destroy
  has_many :wifis, dependent: :destroy
  has_many :banks, dependent: :destroy

  CATEGORIES = %w[wifi mobile bank gym transportation housing utilities community]
  extend FriendlyId
  friendly_id :sku, use: :slugged

  validates :name, presence: true, inclusion: { in: CATEGORIES }
  validates :sku, :form_timer, :description, :subtitle, presence: true

  def path_to_index
    case name
    when 'wifi'
      Rails.application.routes.url_helpers.wifis_path(locale: I18n.locale)
    when 'mobile'
      Rails.application.routes.url_helpers.mobiles_path(locale: I18n.locale)
    when 'bank'
      Rails.application.routes.url_helpers.banks_path(locale: I18n.locale)
    when 'housing'
      Rails.application.routes.url_helpers.real_estate_path(locale: I18n.locale)
    end
  end
end
