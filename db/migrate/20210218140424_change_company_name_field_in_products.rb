class ChangeCompanyNameFieldInProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :company, :company_name
  end
end
