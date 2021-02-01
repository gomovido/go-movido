class RemoveObligationFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :obligation
  end
end
