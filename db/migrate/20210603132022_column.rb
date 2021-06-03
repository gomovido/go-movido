class Column < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :country, null: false, foreign_key: true
  end
end
