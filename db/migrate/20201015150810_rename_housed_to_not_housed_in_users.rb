class RenameHousedToNotHousedInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :housed, :not_housed
    rename_column :products, :logo, :logo_url
  end
end
