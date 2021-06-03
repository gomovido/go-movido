class CreateUserServices < ActiveRecord::Migration[6.1]
  def change
    create_table :user_services do |t|
      t.references :service, null: false, foreign_key: true
      t.references :user_preference, null: false, foreign_key: true

      t.timestamps
    end
  end
end
