require "dry/validation"
require_relative "./har_jbuilder_schema"

ShowJbuilderSchema = Dry::Validation.Schema do
  required(:har).schema(HarJbuilderSchema)
end
