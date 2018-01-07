class Hars::CreateHar
  extend LightService::Organizer

  def self.call(data:)
    with(
      data: data
    ).reduce(
      Hars::CreateHar::BuildHar,
      Hars::CreateHar::BuildEntries,
      Hars::CreateHar::SaveHar
    )
  end
end

class Hars::CreateHar::BuildHar
  extend LightService::Action
  expects :data
  promises :har

  executed do |context|
    page = context.data.dig(:log, :pages)&.first
    context.har = Har.new(
      page_timings_on_content_loaded: page&.dig(:pageTimings, :onContentLoad),
      page_timings_on_load: page&.dig(:pageTimings, :onLoad),
      raw: context.data,
      started_date_time: page&.dig(:startedDateTime),
      title: page&.dig(:title)
    )
  end
end

class Hars::CreateHar::BuildEntries
  extend LightService::Action
  expects :data, :har
  promises :har

  executed do |context|
    context.data.dig(:log, :entries).each do |entry_data|
      timings = entry_data[:timings]
        &.slice(:blocked, :dns, :ssl, :connect, :send, :wait, :receive)
        &.transform_values { |val| HarData.handle_negative(val) }
      context.har.entries.new(
        started_date_time: entry_data[:startedDateTime],
        time: entry_data[:time],
        http_method: entry_data.dig(:request, :method),
        url: entry_data.dig(:request, :url),
        response_status: entry_data.dig(:response, :status),
        response_content_size: HarData.handle_negative(entry_data.dig(:response, :content, :size)),
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

class Hars::CreateHar::SaveHar
  extend LightService::Action
  expects :har
  promises :har

  executed do |context|
    unless context.har.save
      context.fail!(context.har.errors.full_messages, error_code: 1001)
    end
  end
end
