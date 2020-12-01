class RemoveSlugFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :slug
  end
end
