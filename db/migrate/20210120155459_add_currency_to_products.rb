class AddCurrencyToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :currency, :string
    Product.where(country: 'France').each{|product| product.update(currency: '€')}
    Product.where(country: 'United Kingdom').each{|product| product.update(currency: '£')}
  end
end
