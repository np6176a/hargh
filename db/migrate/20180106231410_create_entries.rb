class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.datetime :started_date_time, null: false
      t.decimal :time
      t.string :http_method, null: false
      t.string :url
      t.integer :response_status
      t.decimal :response_content_size
      t.string :response_content_mime_type
      t.decimal :timings_blocked
      t.decimal :timings_dns
      t.decimal :timings_ssl
      t.decimal :timings_connect
      t.decimal :timings_send
      t.decimal :timings_wait
      t.decimal :timings_receive
      t.jsonb :raw, null: false, default: "{}"

      t.timestamps
    end
    add_index :entries, :started_date_time
    add_index :entries, :time
    add_index :entries, :http_method
    add_index :entries, :url
    add_index :entries, :response_status
    add_index :entries, :response_content_size
    add_index :entries, :response_content_mime_type
    add_index :entries, :timings_blocked
    add_index :entries, :timings_dns
    add_index :entries, :timings_ssl
    add_index :entries, :timings_connect
    add_index :entries, :timings_send
    add_index :entries, :timings_wait
    add_index :entries, :timings_receive
  end
end
