class AddFullNameToWifisAndMobiles < ActiveRecord::Migration[6.1]
  def change
    add_column :wifis, :full_name, :string
    add_column :mobiles, :full_name, :string
  end
end
