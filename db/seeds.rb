Category.find_by(name: 'housing').update(sort_id: 1)
Category.find_by(name: 'bank').update(sort_id: 2)
Category.find_by(name: 'mobile').update(sort_id: 3)
Category.find_by(name: 'wifi').update(sort_id: 4)
Category.find_by(name: 'utilities').update(sort_id: 5)
Category.find_by(name: 'transportation').update(sort_id: 6)
Category.find_by(name: 'gym').update(sort_id: 7)
Category.find_by(name: 'community').update(sort_id: 8)
Mobile.all.each do |mobile|
  mobile.product_features.each_with_index do |pf, index|
    pf.update_columns(order: index)
  end
end
Wifi.all.each do |wifi|
  wifi.product_features.each_with_index do |pf, index|
    pf.update_columns(order: index)
  end
end
