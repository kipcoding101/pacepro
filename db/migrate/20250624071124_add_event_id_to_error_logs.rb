class AddEventIdToErrorLogs < ActiveRecord::Migration[8.0]
  def change
    add_reference :error_logs, :event, foreign_key: true, null: false
  end
end
