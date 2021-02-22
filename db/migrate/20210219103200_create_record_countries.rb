class CreateRecordCountries < ActiveRecord::Migration[6.0]
  def change
    Country.create(code: 'gb')
    Country.create(code: 'fr')
  end
end
