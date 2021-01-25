class AddLocaleToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :locale, :string
  end
end
