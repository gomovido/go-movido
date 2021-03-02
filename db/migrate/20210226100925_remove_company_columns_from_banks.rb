class RemoveCompanyColumnsFromBanks < ActiveRecord::Migration[6.0]
  def change
    remove_column :banks, :name, :string
    remove_column :banks, :logo_url, :string
  end
end
