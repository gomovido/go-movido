class AddMobileReferencesToProductFeatures < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_features, :mobile, null: true, foreign_key: true
  end
end
