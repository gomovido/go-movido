class CreateBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :logo_url
      t.string :headline
      t.string :feature_1
      t.string :feature_2
      t.string :feature_3
      t.string :feature_4
      t.string :affiliate_link

      t.timestamps
    end
  end
end
