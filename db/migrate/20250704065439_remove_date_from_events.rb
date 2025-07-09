class RemoveDateFromEvents < ActiveRecord::Migration[8.0]
  def change
    remove_column :events, :date, :date
  end
end
