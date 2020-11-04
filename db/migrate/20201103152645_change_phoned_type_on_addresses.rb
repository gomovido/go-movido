class ChangePhonedTypeOnAddresses < ActiveRecord::Migration[6.0]
  def change
    change_column :addresses, :phoned, 'boolean USING phoned::boolean'
  end
end
