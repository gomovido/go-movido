class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.float :price
      t.string :stripe_id
      t.string :state
      t.string :name
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
