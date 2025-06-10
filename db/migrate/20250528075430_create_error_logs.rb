class CreateErrorLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :error_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.text :message
      t.jsonb :details

      t.timestamps
    end
  end
end
