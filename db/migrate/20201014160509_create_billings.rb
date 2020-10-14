class CreateBillings < ActiveRecord::Migration[6.0]
  def change
    create_table :billings do |t|
      t.string :address
      t.string :first_name
      t.string :last_name
      t.string :bic
      t.string :iban

      t.timestamps
    end
  end
end
