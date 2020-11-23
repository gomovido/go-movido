class AddUkColumnsToBillings < ActiveRecord::Migration[6.0]
  def change
    add_column :billings, :holder_name, :string
    add_column :billings, :account_number, :string
    add_column :billings, :sort_code, :string
  end
end
