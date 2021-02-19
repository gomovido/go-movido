class AssignCountriesToProducts < ActiveRecord::Migration[6.0]
  def change
    Product.all.each do |product|
      if product.country_name == 'United Kingdom'
        product.update(country: Country.find_by(code: 'gb'))
      elsif product.country_name == 'France'
        product.update(country: Country.find_by(code: 'fr'))
      end
    end
  end
end
