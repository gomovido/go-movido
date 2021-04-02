class ChangeDefaultValueOfStartDateInFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    change_column_default :flat_preferences, :start_date, Time.zone.now
  end
end
