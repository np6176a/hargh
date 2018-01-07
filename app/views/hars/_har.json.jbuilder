raise(" partial expects local har") unless binding.local_variable_defined?("har")

json.call(har,
          :id,
          :created_at,
          :started_date_time,
          :title,
          :page_timings_on_content_loaded,
          :page_timings_on_load,
          :entries_count,
          :raw)
