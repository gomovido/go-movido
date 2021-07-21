class CreateOptionValueVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :option_value_variants do |t|
      t.references :variant, null: false, foreign_key: true
      t.references :option_value, null: false, foreign_key: true

      t.timestamps
    end
  end
end
