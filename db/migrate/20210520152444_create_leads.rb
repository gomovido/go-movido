class CreateLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :leads do |t|
      t.string :email
      t.string :campaign_type
      t.timestamps
    end
  end
end
