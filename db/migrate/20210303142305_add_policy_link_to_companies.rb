class AddPolicyLinkToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :policy_link, :string
  end
end
