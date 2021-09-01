class AddProductsReferencesToPlan < ActiveRecord::Migration[6.1]
  def change
    add_reference :plans, :product, null: true, foreign_key: true
  end
end
