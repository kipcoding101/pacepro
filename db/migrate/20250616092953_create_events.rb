class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.string :location
      t.text :description
      t.string :google_form_url
      t.boolean :result_published, default: false, null: false

      t.timestamps
    end
  end
end
