class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :logo_url
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
