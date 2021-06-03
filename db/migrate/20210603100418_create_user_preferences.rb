class CreateUserPreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :user_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.date :arrival
      t.integer :stay_duration

      t.timestamps
    end
  end
end
