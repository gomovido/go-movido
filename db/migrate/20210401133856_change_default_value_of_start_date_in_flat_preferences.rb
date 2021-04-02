class ChangeDefaultValueOfStartDateInFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    change_column :flat_preferences, :start_date, :date, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
