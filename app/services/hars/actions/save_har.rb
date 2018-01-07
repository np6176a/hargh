class Hars::Actions::SaveHar
  extend LightService::Action
  expects :har
  promises :har

  executed do |context|
    unless context.har.save
      context.fail!(context.har.errors.full_messages, error_code: 1001)
    end
  end
end
