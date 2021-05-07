class RemoveCurrencyFromCoupons < ActiveRecord::Migration[6.1]
  def change
    remove_column :coupons, :currency, :string
  end
end
