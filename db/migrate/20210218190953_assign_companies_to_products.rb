class AssignCompaniesToProducts < ActiveRecord::Migration[6.0]
  def change
    Product.all.each do |product|
      product.update(company: Company.find_by(name: product.company_name))
    end
  end
end
