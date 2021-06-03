class CreateBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billings do |t|
      t.string :address

      t.timestamps
    end
  end
end
