class RemoveColumnsFromCoupons < ActiveRecord::Migration[6.1]
  def change
    remove_column :coupons, :duration, :string
    remove_column :coupons, :duration_in_months, :integer
  end
end
