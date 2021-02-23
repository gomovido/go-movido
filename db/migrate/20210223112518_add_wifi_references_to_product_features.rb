class AddWifiReferencesToProductFeatures < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_features, :wifi, null: true, foreign_key: true
  end
end
