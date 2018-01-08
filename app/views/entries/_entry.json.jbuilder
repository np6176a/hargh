raise(" partial expects local entry") unless binding.local_variable_defined?("entry")

json.call(entry,
          :http_method,
          :id,
          :raw,
          :response_content_mime_type,
          :response_content_size,
          :response_status,
          :started_date_time,
          :time,
          :timings_blocked,
          :timings_connect,
          :timings_dns,
          :timings_receive,
          :timings_send,
          :timings_ssl,
          :timings_wait,
          :url
)

