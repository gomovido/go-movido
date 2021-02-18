class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.references :user, null: false, foreign_key: true
      t.date :birthdate
      t.string :birth_city
      t.string :phone

      t.timestamps
    end
  end
end
