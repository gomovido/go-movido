class AddSimNeededToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :sim_needed, :boolean, default: false
  end
end
