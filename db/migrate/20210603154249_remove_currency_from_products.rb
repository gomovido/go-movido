class RemoveCurrencyFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :currency, :string
  end
end
