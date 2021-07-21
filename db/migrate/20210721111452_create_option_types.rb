class CreateOptionTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :option_types do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
