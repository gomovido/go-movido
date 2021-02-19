class AssignCountriesToAddresses < ActiveRecord::Migration[6.0]
  def change
    Address.all.each do |address|
      if address.country_name_for_migration == 'United Kingdom'
        address.update(country: Country.find_by(code: 'gb'))
      elsif address.country_name_for_migration == 'France'
        address.update(country: Country.find_by(code: 'fr'))
      end
    end
  end
end
