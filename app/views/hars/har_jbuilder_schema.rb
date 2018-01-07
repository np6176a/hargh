require "dry/validation"

HarJbuilderSchema = Dry::Validation.Schema do
  required(:id).filled(:int?)
  required(:created_at).filled(:str?)
  required(:started_date_time).filled(:str?)
  required(:title).filled(:str?)
  # Note: Unfortunately, RSpec API Documentation has this issue with making some numbers in a response
  # into strings. Not really great ways around this yet
  required(:page_timings_on_content_loaded) { str? | decimal? | float? | int? }
  required(:page_timings_on_load) { str? | decimal? | float? | int? }
  required(:entries_count) { int? }
  required(:raw).schema(HarSchema)
end
