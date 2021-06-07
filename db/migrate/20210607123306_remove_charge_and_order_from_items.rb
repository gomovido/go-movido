class RemoveChargeAndOrderFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :items, :charge
    remove_reference :items, :order
  end
end
