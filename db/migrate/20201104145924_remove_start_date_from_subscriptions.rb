class RemoveStartDateFromSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :subscriptions, :start_date
  end
end
