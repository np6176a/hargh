require_relative "../../spec/support/sample_raw_data"

FactoryBot.define do
  factory :entry do
    started_date_time { Time.now }
    time { Faker::Number.positive }
    http_method "GET"
    url { Faker::Internet.url }
    response_status { [200, 201, 204, 301, 400, 500].sample }
    response_content_size { Faker::Number.positive }
    response_content_mime_type "application/javascript"
    timings_blocked { Faker::Number.positive }
    timings_dns { Faker::Number.positive }
    timings_ssl { Faker::Number.positive }
    timings_connect { Faker::Number.positive }
    timings_send { Faker::Number.positive }
    timings_wait { Faker::Number.positive }
    timings_receive { Faker::Number.positive }
    raw { SAMPLE_RAW_DATA.dig(:log, :entries).sample }
    har
  end
end
