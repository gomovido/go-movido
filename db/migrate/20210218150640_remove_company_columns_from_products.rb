class RemoveCompanyColumnsFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :company_name
    remove_column :products, :logo_url
  end
end
