class TransfertWifisProductToWifiTable < ActiveRecord::Migration[6.0]
  def change
    Category.find_by(name: 'wifi').products.each do |product|
      wifi = Wifi.new(
        name: product.name,
        area: product.description,
        price: product.price,
        setup_price: product.setup_price,
        active: product.active,
        country: product.country,
        category: product.category,
        company: product.company
        )
      if product.time_contract == 'no'
        wifi.time_contract = 0
      else
        wifi.time_contract = product.time_contract.to_i
      end
      if product.data_speed.split(' ')[0].to_i < 10
        wifi.data_speed = product.data_speed.split(' ')[0].to_i * 1000
      else
        wifi.data_speed = product.data_speed.split(' ')[0].to_i
      end
      wifi.save
      product.product_features.each do |feature|
        feature.update(wifi: wifi)
      end
      product.special_offers.each do |offer|
        offer.update(wifi: wifi)
      end
    end
  end
end
