class Hars::CreateHar::BuildEntries
  extend LightService::Action
  expects :har_schema, :har
  promises :har

  executed do |context|
    context.har_schema.to_h.dig(:log, :entries).each do |entry_data|
      timings = entry_data[:timings]
        &.slice(:blocked, :dns, :ssl, :connect, :send, :wait, :receive)
        &.transform_values { |val| NumHelpers.handle_negative(val) }
      context.har.entries.new(
        started_date_time: entry_data[:startedDateTime],
        time: entry_data[:time],
        http_method: entry_data.dig(:request, :method),
        url: entry_data.dig(:request, :url),
        response_status: entry_data.dig(:response, :status),
        response_content_size: NumHelpers.handle_negative(entry_data.dig(:response, :content, :size)),
        response_content_mime_type: entry_data.dig(:response, :content, :mimeType),
        timings_blocked: timings&.dig(:blocked),
        timings_dns: timings&.dig(:dns),
        timings_ssl: timings&.dig(:ssl),
        timings_connect: timings&.dig(:connect),
        timings_send: timings&.dig(:send),
        timings_wait: timings&.dig(:wait),
        timings_receive: timings&.dig(:receive),
        raw: entry_data
      )
    end
  end
end
