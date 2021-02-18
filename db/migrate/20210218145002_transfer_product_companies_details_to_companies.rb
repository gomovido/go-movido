class TransferProductCompaniesDetailsToCompanies < ActiveRecord::Migration[6.0]
  def change
    Product.all.each do |product|
      Company.create(name: product.company_name, logo_url: product.logo_url)
    end
  end
end
