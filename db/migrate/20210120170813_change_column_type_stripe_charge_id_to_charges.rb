class ChangeColumnTypeStripeChargeIdToCharges < ActiveRecord::Migration[6.0]
  def change
    change_column :charges, :stripe_charge_id, :string

  end
end
