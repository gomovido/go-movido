class CreateUserMarketings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_marketings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :step
      t.boolean :sent
      t.timestamps
    end
  end
end
