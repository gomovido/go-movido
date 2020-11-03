class AddBankDetailsToBillings < ActiveRecord::Migration[6.0]
  def change
    add_column :billings, :bank, :string
  end
end
