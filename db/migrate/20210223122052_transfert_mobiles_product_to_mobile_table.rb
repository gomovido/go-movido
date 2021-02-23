class TransfertMobilesProductToMobileTable < ActiveRecord::Migration[6.0]
  def change
    Category.find_by(name: 'mobile').products.each do |product|
      mobile = Mobile.new(
        name: product.name,
        area: product.description,
        price: product.price,
        sim_card_price: product.sim_card_price,
        category: product.category,
        company: product.company,
        country: product.country,
        active: product.active,
        offer_type: 'internet_and_call'
        )
      if product.sim_needed
        mobile.sim_needed = product.sim_needed
      else
        mobile.sim_needed = false
      end
      if product.time_contract == 'no'
        mobile.time_contract = 0
      else
        mobile.time_contract = product.time_contract.to_i
      end
      if product.data_limit == 'unlimited'
        mobile.data = 0
      else
        mobile.data = product.data_limit.split(' ')[0].to_i
        mobile.data_unit = product.data_limit.split(' ')[1].upcase
      end
      if product.call_limit == 'unlimited'
        mobile.call = 0
      else
        mobile.call = product.call_limit.to_i
      end
      mobile.save
      product.product_features.each do |feature|
        feature.update(mobile: mobile)
      end
      product.special_offers.each do |offer|
        offer.update(mobile: mobile)
      end
    end
  end
end
