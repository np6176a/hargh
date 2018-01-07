require "dry/validation"

CreatorBrowserSchema = Dry::Validation.Schema do
  required(:name).filled(:str?)
  required(:version).filled(:str?)
  optional(:comment).filled(:str?)
end
