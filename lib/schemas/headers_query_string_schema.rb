require "dry/validation"

HeadersQueryStringSchema = Dry::Validation.Schema do
  required(:name).str?
  required(:value).str?
  optional(:comment).str?
end
