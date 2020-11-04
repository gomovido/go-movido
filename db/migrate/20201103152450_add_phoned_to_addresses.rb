class AddPhonedToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :phoned, :string
  end
end
