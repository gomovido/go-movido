class PopulateFullNameInProducts < ActiveRecord::Migration[6.1]
  def change
    Wifi.all.each{|wifi| wifi.set_full_name}
    Mobile.all.each{|mobile| mobile.set_full_name}
  end
end
