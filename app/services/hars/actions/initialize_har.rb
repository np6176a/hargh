class Hars::Actions::InitializeHar
  extend LightService::Action
  promises :har

  executed do |context|
    context.har = Har.new
  end
end
