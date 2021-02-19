class AddCountryReferencesOnAddresses < ActiveRecord::Migration[6.0]
  def change
    add_reference :addresses, :country, null: true, foreign_key: true
  end
end
