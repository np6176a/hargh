class CreateHars < ActiveRecord::Migration[5.1]
  def change
    create_table :hars do |t|
      t.datetime :started_date_time, null: false
      t.string :title, null: false
      t.decimal :page_timings_on_content_loaded, null: false
      t.decimal :page_timings_on_load, null: false

      t.timestamps
    end
    add_index :hars, :started_date_time
    add_index :hars, :page_timings_on_content_loaded
    add_index :hars, :page_timings_on_load
  end
end
