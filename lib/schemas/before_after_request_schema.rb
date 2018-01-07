require "dry/validation"

BeforeAfterRequestSchema = Dry::Validation.Schema do
  optional(:expires).str? # TODO: Make this based on ISO8601
  required(:lastAccess).str? # TODO: Make this based on ISO8601
  required(:eTag).str?
  required(:hitCount).int?
  optional(:comment).str?
end
