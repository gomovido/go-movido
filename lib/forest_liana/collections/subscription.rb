class Forest::Subscription
  include ForestLiana::Collection

  collection :Subscription

  belongs_to :wifi, reference: 'Wifi.id' do
    object.product if object.product_type == 'Wifi'
  end
  belongs_to :mobile, reference: 'Mobile.id' do
    object.product if object.product_type == 'Mobile'
  end

  action 'Activate subscription'
end
