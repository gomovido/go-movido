class AddTypeToCoupons < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :campaign_type, :string
  end
end
