class CreatePacks < ActiveRecord::Migration[6.1]
  def change
    create_table :packs do |t|
      t.string :name

      t.timestamps
    end
  end
end
