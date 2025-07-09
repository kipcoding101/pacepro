class MakeStartAndEndDateNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :events, :start_date, false
    change_column_null :events, :end_date,   false
  end
end
