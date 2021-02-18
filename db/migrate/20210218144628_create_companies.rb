class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo_url
      t.string :cancel_link
      t.timestamps
    end
  end
end
