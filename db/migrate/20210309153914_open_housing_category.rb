class OpenHousingCategory < ActiveRecord::Migration[6.1]
  def change
    Category.find_by(name: 'housing').update(open: true)
  end
end
