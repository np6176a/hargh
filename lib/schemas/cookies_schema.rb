require "dry/validation"

CookiesSchema = Dry::Validation.Schema do
  required(:name).filled(:str?)
  required(:value).str?
  optional(:path).str?
  optional(:domain).str?
  optional(:expires).str? # TODO: Make this based on ISO8601
  optional(:httpOnly).bool?
  optional(:secure).bool?
  optional(:comment).str?
end
