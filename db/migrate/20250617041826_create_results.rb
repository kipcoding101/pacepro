class CreateResults < ActiveRecord::Migration[8.0]
  def change
    create_table :results do |t|
      t.references :event, null: false, foreign_key: true

      # catch-all JSONB for the entire CSV row
      t.jsonb :raw_data, null: false, default: {}

      t.timestamps
    end


    # GIN index lets you query inside raw_data efficiently
    add_index :results, :raw_data, using: :gin
  end
end
