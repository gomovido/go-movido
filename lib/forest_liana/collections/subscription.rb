class Forest::Subscription
  include ForestLiana::Collection

  collection :Subscription

  field :fullname, type: 'String' do
    "#{object.order.user.first_name} #{object.order.user.last_name}"
  end

  field :email, type: 'String' do
    "#{object.order.user.email}"
  end

  field :address, type: 'String' do
    "#{object.order.user.house.house_detail.address}"
  end

  field :country, type: 'String' do
    "#{object.order.user.house.country.code}"
  end

  field :services, type: 'String' do
    "#{object.order.items.map{|i| i.product.name}}"
  end

  field :setup_price, type: 'String' do
    "#{object.order.currency_symbol}#{ActionController::Base.helpers.number_to_currency(object.order.total_amount_display, :unit => '')}"
  end

  field :monthly_price, type: 'String' do
    "#{object.order.currency_symbol}#{ActionController::Base.helpers.number_to_currency(object.order.total_subscription_amount_display, :unit => '')}"
  end

end
