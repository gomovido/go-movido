class RemoveArrivalAndStayDurationFromUserPreferences < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_preferences, :arrival, :date
    remove_column :user_preferences, :stay_duration, :integer
  end
end
