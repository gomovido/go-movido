class RemoveSlugIndexFromProducts < ActiveRecord::Migration[6.0]
  def change
     remove_index(:products, name: 'index_products_on_slug')
  end
end
