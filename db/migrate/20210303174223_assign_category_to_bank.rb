class AssignCategoryToBank < ActiveRecord::Migration[6.0]
  def change
    Bank.find_by(company: Company.find_by(name: 'Bunq')).update(category: Category.find_by(name: 'bank'))
    Bank.find_by(company: Company.find_by(name: 'TransferWise')).update(category: Category.find_by(name: 'bank'))
  end
end
