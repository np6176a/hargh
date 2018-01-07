class Hars::CreateHar::ValidateSchema
  extend LightService::Action
  expects :params
  promises :har_schema

  executed do |context|
    context.har_schema = HarSchema.call(context.params)
    if context.har_schema.failure?
      context.fail!(context.har_schema.errors, error_code: 1002)
    end
  end
end
