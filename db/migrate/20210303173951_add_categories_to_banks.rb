class AddCategoriesToBanks < ActiveRecord::Migration[6.0]
  def change
    add_reference :banks, :category, null: true, foreign_key: true
  end
end
