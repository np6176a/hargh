FactoryBot.define do
  factory :har do
    started_date_time { Time.now }
    title { Faker::Company.name }
    page_timings_on_content_loaded { Faker::Number.positive }
    page_timings_on_load { Faker::Number.positive }
    raw SAMPLE_RAW_ENTRY
  end
end
