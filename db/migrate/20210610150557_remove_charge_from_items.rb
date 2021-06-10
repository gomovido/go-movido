class RemoveChargeFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :items, :charge
  end
end
