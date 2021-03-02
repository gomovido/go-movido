class AddCompanyReferencesToBanks < ActiveRecord::Migration[6.0]
  def change
    add_reference :banks, :company, null: true, foreign_key: true
  end
end
